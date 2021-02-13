import Foundation

struct UserText {
    static let appName = "Frame Grabber"
    static let photoLibraryAppAlbum = appName
    static let exifAppInformation = "\(appName) \(Bundle.main.version)"

    static let okAction = NSLocalizedString("action.ok", value: "OK", comment: "Ok action")
    static let cancelAction = NSLocalizedString("action.cancel", value: "Cancel", comment: "Cancel action")
    static let deleteAction = NSLocalizedString("action.delete", value: "Delete", comment: "Delete context action")
    static let favoriteAction = NSLocalizedString("action.favorite", value: "Favorite", comment: "Favorite context action")
    static let unfavoriteAction = NSLocalizedString("action.unfavorite", value: "Unfavorite", comment: "Unfavorite context action")
    static let openSettingsAction = NSLocalizedString("action.settings", value: "Settings", comment: "Open settings action")

    static let authorizationDeniedMessage = NSLocalizedString("authorization.denied.message", value: "Frame Grabber works in unison with your photo library. Get started by allowing access in Settings.", comment: "Photo library authorization denied message")
    static let authorizationDeniedAction = NSLocalizedString("authorization.denied.action", value: "Open Settings", comment: "Photo library authorization denied action.")
    static let authorizationUndeterminedMessage = NSLocalizedString("authorization.undetermined.message", value: "Frame Grabber works in unison with your photo library. Get started by allowing access to your videos and photos.", comment: "Photo library authorization default message")
    static let authorizationUndeterminedAction = NSLocalizedString("authorization.undetermined.action", value: "Get Started", comment: "Photo library authorization default action")

    static let aboutVersionFormat = NSLocalizedString("about.version.format", value: "Version %@", comment: "Version label with numerical version")
    static let aboutContactSubject = NSLocalizedString("about.email.subject", value: "Frame Grabber: Feedback", comment: "Feedback email subject")

    static let IAPAction = NSLocalizedString("iap.purchase.action", value: "Send Ice Cream", comment: "Purchase screen purchase button label")

    static let albumsUserAlbumsHeader = NSLocalizedString("albums.header.useralbum", value: "My Albums", comment: "User photo albums section header")

    static let libraryDefaultTitle = NSLocalizedString("library.default.title", value: "Library", comment: "Title for the library when no specific album is selected.")
    static let albumLimitedAuthorizationTitle = libraryDefaultTitle
    static let albumEmptyAny = NSLocalizedString("album.empty.any", value: "No Videos or Live Photos", comment: "Empty album message")
    static let albumEmptyVideos = NSLocalizedString("album.empty.video", value: "No Videos", comment: "No videos in album message")
    static let albumEmptyLive = NSLocalizedString("album.empty.livePhoto", value: "No Live Photos", comment: "No live photos in album message")
    static let albumViewSettingsMenuTitle = NSLocalizedString("album.viewSettings.menu.title", value: "Show", comment: "Title of album view settings button menu")
    static let albumViewSettingsSquareGridTitle = NSLocalizedString("album.viewSettings.squareGrid.title", value: "Square Grid", comment: "Title of album view as squares settings menu item")
    static let albumViewSettingsFitGridTitle = NSLocalizedString("album.viewSettings.fitGrid.title", value: "Aspect Ratio Grid", comment: "Title of album view as aspect ratio settings menu item")
    
    static let libraryImportFileMenuAction = NSLocalizedString("library.menu.import.file.action", value: "Open a File", comment: "Action of import menu: Open file picker action.")
    static let libraryImportCameraMenuAction = NSLocalizedString("library.menu.import.camera.action", value: "Record a Video", comment: "Action of import menu: Open camera action.")
    static let libraryImportSelectMorePhotosMenuAction = NSLocalizedString("library.menu.import.selectPhotos.action", value: "Select More Videos", comment: "Action of import menu: Select more photos in limited authorization.")
    static let libraryImportLimitedAuthorizationTitle = NSLocalizedString("library.menu.import.limited.title", value: "You've given Frame Grabber access to a limited number of videos.", comment: "Title for limited authorization menu.")
    
    static let videoFilterAllItems = NSLocalizedString("videofilter.all", value: "All Items", comment: "Video filter title, all items")
    static let videoFilterVideos = NSLocalizedString("videofilter.video", value: "Videos", comment: "Video filter title, only videos")
    static let videoFilterLivePhotos = NSLocalizedString("videofilter.livePhoto", value: "Live Photos", comment: "Video filter title, only Live Photos")

    static let editorVideoLoadProgress = NSLocalizedString("progress.videoLoad.title", value: "Loading…", comment: "Video loading (iCloud or otherwise) progress title.")
    static let editorExportShareSheetProgress = NSLocalizedString("progress.export.shareSheet.title", value: "Exporting…", comment: "Frame generation progress title when showing the share sheet.")
    static let editorExportToPhotosProgress = NSLocalizedString("progress.export.saveToPhotos.title", value: "Saving to Photos…", comment: "Frame generation progress title when saving to Photos.")
    static let editorViewMetadataAction = NSLocalizedString("editor.more.metadata.action", value: "Metadata", comment: "Editor more button metadata button action")
    static let editorViewExportSettingsAction = NSLocalizedString("editor.more.exportSettings.action", value: "Settings", comment: "Editor more button export settings action")
    
    static let speedMenuTitle = NSLocalizedString("editor.menu.speed.title", value: "Set the speed for scrubbing through the video.", comment: "Title for the speed menu.")
    static let speedMenuNormalSpeedAction = NSLocalizedString("editor.menu.speed.normal.action", value: "Normal", comment: "Title for the normal speed in the speed menu.")
    static let speedMenuHalfSpeedAction = NSLocalizedString("editor.menu.speed.half.action", value: "Half", comment: "Title for the half speed in the speed menu.")
    static let speedMenuQuarterSpeedAction = NSLocalizedString("editor.menu.speed.quarter.action", value: "Quarter", comment: "Title for the quarter speed in the speed menu.")
    static let speedMenuFineSpeedAction = NSLocalizedString("editor.menu.speed.fine.action", value: "Fine", comment: "Title for the fine speed in the speed menu.")
    static let speedMenuVeryFineSpeedAction = NSLocalizedString("editor.menu.speed.veryFine.action", value: "Snail", comment: "Title for the very fine speed in the speed menu.")
    
    static let editorDetailSettingsSectionTitle = NSLocalizedString("editor.detail.settings.title", value: "Settings", comment: "Title for the settings section.")
    static let editorDetailMetadataSectionTitle = NSLocalizedString("editor.detail.metadata.title", value: "Metadata", comment: "Title for the metadata section.")
    
    static let exportImageFormatHeifSupportedFooter = NSLocalizedString("exportsettings.section.format.heifSupported.footer", value: "HEIF can result in a smaller file size. JPEG is most widely supported.", comment: "Explanation of image formats in settings footer")
    static let exportImageFormatHeifNotSupportedFooter = NSLocalizedString("exportsettings.section.format.heifNotSupported.footer", value: "The HEIF format is not supported on this device.", comment: "Explanation of image formats in settings footer when HEIF is not supported")
    static let exportSettingsShowShareSheetFooter = NSLocalizedString("exportsettings.showShareSheet.footer", value: "Directly send your photos to AirDrop, Instagram, Messages and many other apps.", comment: "Explanation of what the share sheet setting does")
    static let exportSettingsSaveToPhotosFooter = NSLocalizedString("exportsettings.saveToPhotos.footer", value: "Saves photos to your photo library and adds them to the “Frame Grabber” album.", comment: "Explanation of what the save to photos setting does")
    static let exportShowShareSheetAction = NSLocalizedString("export.showShareSheet.action", value: "Share Sheet", comment: "Title for the share sheet export setting.")
    static let exportSettingsFrameNumberFormatFooter = NSLocalizedString("exportsettings.frameNumber.footer", value: "Minutes, seconds and the frame number relative to the current second.\n\nFor large videos, it might take a bit longer to determine the frame numbers.", comment: "Explanation of what the frame number time format does.")
    static let exportSaveToPhotosAction = NSLocalizedString("exportsettings.saveToPhotos.action", value: "Photos", comment: "Title for the save to photo library export setting.")
    static let exportSettingsMillisecondsFormatFooter = NSLocalizedString("exportsettings.milliseconds.footer", value: "Minutes, seconds and milliseconds.", comment: "Explanation of what the milliseconds time format does.")
    static let exportMillisecondsFormatTitle = NSLocalizedString("settings.milliseconds.title", value: "Milliseconds", comment: "Title for the milliseconds time format setting.")
    static let exportMillisecondsFormat = NSLocalizedString("settings.milliseconds.format", value: "mm:ss.SSS", comment: "The milliseconds format, used for display (but not for actual formatting).")
    static let exportFrameNumberFormatTitle = NSLocalizedString("settings.frameNumber.title", value: "Frames", comment: "Title for the frame number time format setting.")
    static let exportFrameNumberFormat = NSLocalizedString("settings.frameNumber.format", value: "mm:ss / ff", comment: "The frame number format, used for display (but not for actual formatting).")

    static let formatterFrameRateFormat = NSLocalizedString("formatter.framerate.format",  value: "%@ fps", comment: "Video frame rate with unit")
    static let formatterDimensionsFormat = NSLocalizedString("formatter.videodimensions.format", value: "%@ × %@ px", comment: "Video pixel size with unit")
        
    struct Metadata {
        static let typeTitle = NSLocalizedString("metadata.type.title", value: "Type", comment: "Title for the video type metadata.")
        static let typeVideoValue = NSLocalizedString("metadata.type.video", value: "Video", comment: "Video: Value for the video type metadata item.")
        static let typeLivePhotoValue = NSLocalizedString("metadata.type.livePhoto", value: "Live Photo", comment: "Live Photo: Value for the video type metadata.")
        
        static let dimensionsTitle = NSLocalizedString("metadata.dimensions.title", value: "Dimensions", comment: "Video: Title for the dimensions metadata.")
        static let dimensionsLivePhotoVideoTitle = NSLocalizedString("metadata.dimensions.video.title", value: "Video Dimensions", comment: "Live Photo: Title for the dimensions metadata of the video component.")
        static let dimensionsLivePhotoPictureTitle = NSLocalizedString("metadata.dimensions.livePhoto.title", value: "Photo Dimensions", comment: "Live Photo: Title for the dimensions metadata of the picture component")
        
        static let creationDateTitle = NSLocalizedString("metadata.creationDate.title", value: "Created", comment: "Title for the creation date metadata.")
        static let cameraMakeTitle = NSLocalizedString("metadata.make.title", value: "Device Make", comment: "Title for the camera make metadata.")
        static let cameraModelTitle = NSLocalizedString("metadata.model.title", value: "Device Model", comment: "Title for the camera model metadata.")
        static let softwareTitle = NSLocalizedString("metadata.software.title", value: "Software", comment: "Title for the software metadata.")
        static let frameRateTitle = NSLocalizedString("metadata.frameRate.title", value: "Frame Rate", comment: "Title for the frame rate metadata.")
        static let durationTitle = NSLocalizedString("metadata.duration.title", value: "Duration", comment: "Title for the duration metadata.")
        static let formatTitle = NSLocalizedString("metadata.format.title", value: "Kind", comment: "Title for the file format metadata.")
        static let codecTitle = NSLocalizedString("metadata.codec.title", value: "Codec", comment: "Title for the codec metadata.")
        static let fileSizeTitle = NSLocalizedString("metadata.size.title", value: "Size", comment: "Title for the file size metadata.")
        
        static let mapItemTitle = NSLocalizedString("metadata.mapItem.title", value: "Location of Video", comment: "Title of map item to be opened in Maps app.")
    }
}

extension UserText {
    static let alertFilePickingFailedTitle = NSLocalizedString("alert.filePicker.title", value: "Could not Open Video", comment: "")
    static let alertFilePickingFailedMessage = NSLocalizedString("alert.filePicker.message", value: "There was an error importing the file.", comment: "")
    
    static let alertVideoLoadFailedTitle = NSLocalizedString("alert.videoload.title", value: "Unable to Load Item", comment: "")
    static let alertVideoLoadFailedMessage = NSLocalizedString("alert.videoload.message", value: "Please check your network settings and make sure the format is supported on this device.", comment: "")
    
    static let videoRecordingUnavailableTitle = NSLocalizedString("alert.camera.unavailable.title", value: "Camera Unavailable", comment: "Alert title when the current device cannot record videos.")
    static let videoRecordingUnavailableMessage = NSLocalizedString("alert.camera.unavailable.message", value: "This device cannot record videos.", comment: "Alert message when the current device cannot record videos.")
    static let videoRecordingDeniedTitle = NSLocalizedString("alert.camera.denied.title", value: "No Camera Access", comment: "Alert title when the recording authorization is denied or restricted.")
    static let videoRecordingDeniedMessage = NSLocalizedString("alert.camera.denied.message", value: "You have denied Frame Grabber the access to your camera.", comment: "Alert message when the recording authorization is denied or restricted..")
    static let videoRecordingFailedTitle = NSLocalizedString("alert.camera.failed.title", value: "Cannot Open Video", comment: "Alert title when the video recording failed for any reason.")
    static let videoRecordingFailedMessage = NSLocalizedString("alert.camera.failed.message", value: "There was an error during the recording.", comment: "Alert message when the video recording failed for any reason")

    static let alertPlaybackFailedTitle = NSLocalizedString("alert.playback.title", value: "Cannot Play Item", comment: "")
    static let alertPlaybackFailedMessage = NSLocalizedString("alert.playback.message", value: "There was an error during playback.", comment: "")

    static let alertFrameExportFailedTitle = NSLocalizedString("alert.frameexport.title", value: "Unable to Export Image", comment: "")
    static let alertFrameExportFailedMessage = NSLocalizedString("alert.frameexport.message", value: "There was an error while generating the image.", comment: "")

    static let alertSavingToPhotosFailedTitle = NSLocalizedString("alert.saveToPhotos.title", value: "Unable to Save Image", comment: "")
    static let alertSavingToPhotosFailedMessage = NSLocalizedString("alert.saveToPhotos.message", value: "There was an error saving the image to Photos.", comment: "")
    
    static let alertMailUnavailableTitle = NSLocalizedString("alert.mail.title", value: "This Device Can't Send Emails", comment: "")
    static let alertMailUnavailableMessageFormat = NSLocalizedString("alert.mail.message", value: "You can reach me at %@", comment: "E-mail address")

    static let alertIAPFailedTitle = NSLocalizedString("alert.iap.failed.title", value: "Cannot Purchase Ice Cream", comment: "Alert title: Purchasing failed.")
    static let alertIAPFailedMessage = NSLocalizedString("alert.iap.failed.message", value: "Please check your network settings and try again later. Thank you for your support!", comment: "Alert message: The purchase can't proceed because the product has not yet been fetched, usually due to network errors.")

    static let alertIAPUnauthorizedTitle = UserText.alertIAPFailedTitle
    static let alertIAPUnauthorizedMessage = NSLocalizedString("alert.iap.unauthorized.message", value: "In-App Purchases are not allowed on this device. Thank you for your support!", comment: "Alert message: The user is not authorized to make payments.")

    static let alertIAPUnavailableTitle = UserText.alertIAPFailedTitle
    static let alertIAPUnavailableMessage = UserText.alertIAPFailedMessage

    static let alertIAPRestoreFailedTitle = NSLocalizedString("alert.iap.restore.failed.title", value: "Cannot Restore Your Purchase", comment: "Alert title: Restoring failed.")
    static let alertIAPRestoreFailedMessage = UserText.alertIAPFailedMessage

    static let alertIAPRestoreUnauthorizedTitle = UserText.alertIAPRestoreFailedTitle
    static let alertIAPRestoreUnauthorizedMessage = UserText.alertIAPUnauthorizedMessage

    static let alertIAPRestoreEmptyTitle = NSLocalizedString("alert.iap.restore.empty.title", value: "Nothing to Restore", comment: "Alert title: Nothing to restore, the user has not previously purchased anything.")
    static let alertIAPRestoreEmptyMessage = NSLocalizedString("alert.iap.restore.empty.message", value: "Looks like you haven't sent any ice cream yet!", comment: "Alert message: Nothing to restore, the user has not previously purchased anything. ")
}
