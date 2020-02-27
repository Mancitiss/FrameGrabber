import UIKit
import Combine

class VideoCell: UICollectionViewCell {

    var identifier: String?
    var imageRequest: Cancellable?

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var favoritedImageView: UIImageView!
    @IBOutlet var gradientView: GradientView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        identifier = nil
        imageRequest = nil
        imageView.image = nil
        durationLabel.text = nil
        favoritedImageView.isHidden = true
    }

    private func configureViews() {
        gradientView.colors = Style.Color.videoCellGradient
        favoritedImageView.isHidden = true
    }
}
