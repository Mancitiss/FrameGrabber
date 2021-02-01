import CoreGraphics
import CoreLocation
import Foundation
import ImageIO

struct ImageMetadata {
    
    /// A dictionary of CGImageProperty metadata keys and their values.
    typealias Properties = [CFString: Any]

    /// The metadata properties.
    let properties: Properties
}

// MARK: - Factories

extension ImageMetadata {
    
    static func metadata(
        forCreationDate date: Date? = nil,
        location: CLLocation? = nil,
        make: String? = nil,
        model: String? = nil,
        software: String? = nil,
        userComment: String? = nil
    ) -> ImageMetadata {
        
        var properties = Properties()

        let exif = exifProperties(forCreationDate: date, userComment: userComment)
        let tiff = tiffProperties(forCreationDate: date, make: make, model: model, software: software)
                
        properties.setIfNotNil(kCGImagePropertyExifDictionary, exif.isEmpty ? nil : exif)
        properties.setIfNotNil(kCGImagePropertyTIFFDictionary, tiff.isEmpty ? nil : tiff)
        
        if let location = location {
            properties[kCGImagePropertyGPSDictionary] = gpsProperties(for: location)
        }

        return ImageMetadata(properties: properties)
    }

    static func exifProperties(
        forCreationDate date: Date? = nil,
        userComment: String? = nil
    ) -> Properties {
        
        var properties = Properties()
        let exifDate = date.flatMap(DateFormatter.exifDateTimeFormatter().string)
            
        properties.setIfNotNil(kCGImagePropertyExifDateTimeOriginal, exifDate as CFString?)
        properties.setIfNotNil(kCGImagePropertyExifDateTimeDigitized, exifDate as CFString?)
        properties.setIfNotNil(kCGImagePropertyExifUserComment, userComment as CFString?)
            
        return properties
    }

    static func tiffProperties(
        forCreationDate date: Date? = nil,
        make: String? = nil,
        model: String? = nil,
        software: String? = nil
    ) -> Properties {
        
        var properties = Properties()
        let exifDate = date.flatMap(DateFormatter.exifDateTimeFormatter().string)
        
        properties.setIfNotNil(kCGImagePropertyTIFFDateTime, exifDate as CFString?)
        properties.setIfNotNil(kCGImagePropertyTIFFMake, make as CFString?)
        properties.setIfNotNil(kCGImagePropertyTIFFModel, model as CFString?)
        properties.setIfNotNil(kCGImagePropertyTIFFSoftware, software as CFString?)
        
        return properties
    }

    static func gpsProperties(for location: CLLocation) -> Properties {
        let gpsDateString = DateFormatter.GPSTimeStampFormatter().string(from: location.timestamp)
        let coordinate = location.coordinate

        return [
            kCGImagePropertyGPSTimeStamp: gpsDateString as CFString,
            kCGImagePropertyGPSLatitude: abs(coordinate.latitude),  // Note: not CFString
            kCGImagePropertyGPSLatitudeRef: (coordinate.latitude >= 0 ? "N" : "S") as CFString,
            kCGImagePropertyGPSLongitude: abs(coordinate.longitude),
            kCGImagePropertyGPSLongitudeRef: (coordinate.longitude >= 0 ? "E" : "W") as CFString,
            kCGImagePropertyGPSHPositioningError: location.horizontalAccuracy
        ]
    }
}

// MARK: - Formatters

private extension DateFormatter {

    static func exifDateTimeFormatter() -> DateFormatter {
        let formatter = GPSTimeStampFormatter()
        // Exif dates are in "local" time without any timezone (whatever that means…).
        formatter.timeZone = .current
        return formatter
    }

    static func GPSTimeStampFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_POSIX_US")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return formatter
    }
}

// MARK: - Util

private extension Dictionary {
    mutating func setIfNotNil(_ key: Key, _ value: Value?) {
        guard let value = value else { return }
        self[key] = value
    }
}
