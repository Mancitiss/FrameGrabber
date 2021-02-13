import UIKit

class EmptyLibraryView: UIView {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .title3, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    var isEmpty: Bool = true {
        didSet { updateViews() }
    }

    var type: PhotoLibraryFilter = .videoAndLivePhoto {
        didSet { updateViews() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }

    private func configureViews() {
        addSubview(titleLabel)
        configureConstraints()
        updateViews()
    }

    private func updateViews() {
        titleLabel.text = isEmpty ? type.emptyMessage : nil
    }

    private func configureConstraints() {
        let margin: CGFloat = -16
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: margin).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: margin).isActive = true
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: margin).isActive = true
        titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: margin).isActive = true
    }
}

private extension PhotoLibraryFilter {

    var emptyMessage: String {
        switch self {
        case .videoAndLivePhoto: return UserText.albumEmptyAny
        case .video: return UserText.albumEmptyVideos
        case .livePhoto: return UserText.albumEmptyLive
        }
    }
}
