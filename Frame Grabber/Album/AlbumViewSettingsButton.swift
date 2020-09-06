import UIKit

class AlbumViewSettingsButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }

    private func configureViews() {
        clipsToBounds = true
        layer.cornerRadius = Style.buttonCornerRadius
        layer.cornerCurve = .continuous

        titleLabel?.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        titleLabel?.adjustsFontForContentSizeCategory = true

        backgroundColor = UIColor.systemGray5.withAlphaComponent(0.95)
        setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
    }
}
