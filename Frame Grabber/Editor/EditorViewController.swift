import AVFoundation
import Combine
import ThumbnailSlider
import UIKit

class EditorViewController: UIViewController {

    var videoController: VideoController!
    var transitionController: ZoomTransitionController?

    // MARK: Private Properties

    private lazy var playbackController = PlaybackController()
    private lazy var timeFormatter = VideoTimeFormatter()
    private var sliderDataSource: AVAssetThumbnailSliderDataSource?
    private lazy var selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    private lazy var bindings = Set<AnyCancellable>()

    @IBOutlet private var titleView: EditorTitleView!
    @IBOutlet private var toolbar: EditorToolbar!
    @IBOutlet private var zoomingPlayerView: ZoomingPlayerView!
    @IBOutlet private var scrubbingIndicator: ScrubbingIndicatorView!
    @IBOutlet private var progressView: ProgressView!

    private var isScrubbing: Bool {
        toolbar.timeSlider.isTracking
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        loadPreviewImage()
        loadVideo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoController.cancelFrameExport()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UINavigationController,
            let controller = destination.topViewController as? MetadataViewController {

            prepareForMetadataSegue(with: controller)
        }
    }

    private func prepareForMetadataSegue(with controller: MetadataViewController) {
        playbackController.pause()
        controller.videoController = VideoController(asset: videoController.asset, video: videoController.video)
    }
}

// MARK: - Private

private extension EditorViewController {

    // MARK: Actions

    func done() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func playOrPause() {
        guard !isScrubbing else { return }
        playSelectionFeedback()
        playbackController.playOrPause()
    }

    @IBAction func stepBackward() {
        guard !isScrubbing else { return }
        playSelectionFeedback()
        playbackController.step(byCount: -1)
    }

    @IBAction func stepForward() {
        guard !isScrubbing else { return }
        playSelectionFeedback()
        playbackController.step(byCount: 1)
    }

    @IBAction func shareFrames() {
        guard !isScrubbing else { return }

        playSelectionFeedback()
        playbackController.pause()
        generateFramesAndShare(for: [playbackController.currentFrameTime])
    }

    @IBAction func scrub(_ sender: ScrubbingThumbnailSlider) {
        playbackController.smoothlySeek(to: sender.time)
    }

    @objc func showMoreMenuAsAlertSheet() {
        let alertController = EditorMoreMenu.alertController { [weak self] selection in
            self?.performSegue(withIdentifier: selection.rawValue, sender: nil)
        }

        presentOnTop(alertController)
    }

    private func playSelectionFeedback() {
        selectionFeedbackGenerator.selectionChanged()
        selectionFeedbackGenerator.prepare()
    }

    // MARK: Configuring

    func configureViews() {
        zoomingPlayerView.clipsToBounds = false
        zoomingPlayerView.player = playbackController.player
        zoomingPlayerView.posterImage = videoController.previewImage

        scrubbingIndicator.configure(for: toolbar.timeSlider)

        sliderDataSource = AVAssetThumbnailSliderDataSource(
            slider: toolbar.timeSlider,
            asset: videoController.video,
            placeholderImage: videoController.previewImage
        )

        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem?.menu = EditorMoreMenu.menu { [weak self] selection in
                self?.performSegue(withIdentifier: selection.rawValue, sender: nil)
            }
        } else {
            navigationItem.rightBarButtonItem?.target = self
            navigationItem.rightBarButtonItem?.action = #selector(showMoreMenuAsAlertSheet)
        }

        configureNavigationBar()
        configureGestures()
        bindPlayer()
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.applyToolbarShadow()
        toolbar.applyToolbarShadow()
    }

    func configureGestures() {
        guard transitionController != nil else { return }

        let slideToPopRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSlideToPopPan))
        zoomingPlayerView.addGestureRecognizer(slideToPopRecognizer)

        if let defaultPopRecognizer = navigationController?.interactivePopGestureRecognizer {
            slideToPopRecognizer.require(toFail: defaultPopRecognizer)
        }
    }

    @objc func handleSlideToPopPan(_ gesture: UIPanGestureRecognizer) {
        let hasVideoOrPoster = zoomingPlayerView.playerView.bounds.size != .zero

        guard !isScrubbing,
            hasVideoOrPoster else { return }

        transitionController?.handleSlideToPopGesture(gesture, performTransition: {
            done()
        })
    }

    func presentOnTop(_ viewController: UIViewController, animated: Bool = true) {
        let presenter = navigationController ?? presentedViewController ?? self
        presenter.present(viewController, animated: animated)
    }

    func bindPlayer() {
        playbackController
            .$status
            .map { $0 == .readyToPlay }
            .sink { [weak self] in
                self?.titleView.setEnabled($0)
                self?.toolbar.setEnabled($0)
                self?.navigationItem.rightBarButtonItem?.isEnabled = $0
            }
            .store(in: &bindings)

        playbackController
            .$status
            .filter { $0 == .failed }
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.presentOnTop(UIAlertController.playbackFailed())
            }
            .store(in: &bindings)

        playbackController
            .$duration
            .assignWeak(to: \.duration, on: toolbar.timeSlider)
            .store(in: &bindings)

        playbackController
            .$currentFrameTime
            .sink { [weak self] time in
                self?.updateTimeLabel(withTime: time)
            }
            .store(in: &bindings)

        playbackController
            .$currentPlaybackTime
            .sink { [weak self] time in
                guard self?.isScrubbing == false else { return }
                self?.toolbar.timeSlider.setTime(time, animated: true)
            }
            .store(in: &bindings)

        playbackController
            .$timeControlStatus
            .sink { [weak self] in
                self?.toolbar.playButton.setTimeControlStatus($0)
            }
            .store(in: &bindings)
    }

    func updateTimeLabel(withTime time: CMTime) {
        let showMilliseconds = !playbackController.isPlaying
        let formattedTime = timeFormatter.string(fromCurrentTime: time, includeMilliseconds: showMilliseconds)
        titleView.setFormattedTime(formattedTime, animated: true)
    }

    // MARK: Loading Videos

    func loadPreviewImage() {
        let size = zoomingPlayerView.bounds.size.scaledToScreen

        videoController.loadPreviewImage(with: size) { [weak self] image, _ in
            guard let image = image else { return }
            self?.zoomingPlayerView.posterImage = image
        }
    }

    func loadVideo() {
        showProgress(true, forActivity: .load, value: .determinate(0))

        videoController.loadVideo(progressHandler: { [weak self] progress in
            self?.progressView.setProgress(.determinate(Float(progress)), animated: true)
        }, completionHandler: { [weak self] result in
            self?.showProgress(false, forActivity: .load, value: .determinate(1))
            self?.handleVideoLoadingResult(result)
        })
    }

    func handleVideoLoadingResult(_ result: VideoController.VideoResult) {
        switch result {

        case .failure(let error):
            guard !error.isCocoaCancelledError else { return }
            presentOnTop(UIAlertController.videoLoadingFailed())

        case .success(let video):
            playbackController.asset = video
            playbackController.play()
            sliderDataSource?.asset = video
        }
    }

    // MARK: Generating Images

    func generateFramesAndShare(for times: [CMTime]) {
        showProgress(true, forActivity: .export, value: .indeterminate)

        videoController.generateAndExportFrames(for: times) { [weak self] status in
            self?.showProgress(false, forActivity: .export) {
                self?.handleFrameGenerationResult(status)
            }
        }
    }

    func handleFrameGenerationResult(_ status: FrameExport.Status) {
        let feedbackGenerator = UINotificationFeedbackGenerator()

        switch status {
        case .cancelled, .progressed:
            break
        case .failed:
            presentOnTop(UIAlertController.frameExportFailed())
        case .succeeded(let urls):
            share(urls: urls)
        }

        status.feedback.flatMap(feedbackGenerator.notificationOccurred)
    }

    func share(urls: [URL]) {
        let shareController = UIActivityViewController(activityItems: urls, applicationActivities: nil)

        shareController.completionWithItemsHandler = { [weak self] activity, completed, _, _ in
            guard self?.shouldDeleteFrames(after: activity, completed: completed) == true  else { return }
            self?.videoController.deleteExportedFrames()
        }

        presentOnTop(shareController)
    }

    func shouldDeleteFrames(after shareActivity: UIActivity.ActivityType?, completed: Bool) -> Bool {
        let wasDismissed = (shareActivity == nil) && !completed
        let didFinish = (shareActivity != nil) && completed
        return wasDismissed || didFinish
    }

    // MARK: Showing Progress

    enum Activity {
        case load
        case export

        var title: String {
            switch self {
            case .load: return UserText.editorVideoLoadProgress
            case .export: return UserText.editorExportProgress
            }
        }

        var delay: TimeInterval {
            switch self {
            case .load: return 0.25
            case .export: return 0.1
            }
        }
    }

    func showProgress(_ show: Bool, forActivity activity: Activity, value: ProgressView.Progress? = nil, animated: Bool = true, completion: (() -> ())? = nil) {
        view.isUserInteractionEnabled = !show 

        progressView.showDelay = activity.delay
        progressView.titleLabel.text = activity.title
        
        if show {
            progressView.show(in: zoomingPlayerView, animated: animated, completion: completion)
        } else {
            progressView.hide(animated: animated, completion: completion)
        }

        if let value = value {
            progressView.setProgress(value, animated: animated)
        }
    }
}

// MARK: - ZoomTransitionDelegate

extension EditorViewController: ZoomTransitionDelegate {

    func zoomTransitionWillBegin(_ transition: ZoomTransition) {
        guard transition.type == .pop else { return }

        let backgroundColor = view.backgroundColor

        transition.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else { return }
            self.view.backgroundColor = .clear
            self.progressView.alpha = 0
            self.toolbar.alpha = 0
            self.toolbar.transform = CGAffineTransform.identity.translatedBy(x: 0, y: self.toolbar.bounds.height * 1.5)
        }, completion: { [weak self] _ in
            // Animation interpolates dynamic to fixed color. Restore dynamic color.
            self?.view.backgroundColor = backgroundColor
        })
    }

    func zoomTransitionView(_ transition: ZoomTransition) -> UIView? {
        zoomingPlayerView.playerView
    }
}

private extension FrameExport.Status {
    var feedback: UINotificationFeedbackGenerator.FeedbackType? {
        switch self {
        case .cancelled: return .warning
        case .failed: return .error
        case .progressed: return nil
        case .succeeded: return .success
        }
    }
}
