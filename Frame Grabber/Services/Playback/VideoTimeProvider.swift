import AVFoundation
import CoreMedia
import FrameIndexer

/// Provides frame-accurate timing information for an asset.
class VideoTimeProvider {

    var asset: AVAsset? {
        didSet {
            guard asset != oldValue else { return }
            indexFrames()
        }
    }

    /// If true, starts asynchronously indexing the asset's frames and, when finished successfully, provides
    /// frame-accurate timing in `time(for:)`. Otherwise, cancels indexing and discards indexed frames.
    var providesFrameAccurateTiming = true {
        didSet {
            guard providesFrameAccurateTiming != oldValue else { return }
            indexFrames()
        }
    }

    private var indexedFrames: IndexedFrames?
    private let indexer: FrameIndexer

    init(asset: AVAsset? = nil, indexer: FrameIndexer = .init()) {
        self.asset = asset
        self.indexer = indexer
        indexFrames()
    }

    /// The start time of the frame closest to the requested time or, if not available, the requested time.
    ///
    /// For the receiver to provide frame-accurate times, `providesFrameAccurateTiming` must be true and the
    /// asynchronous frame indexing operation must have finished successfully.
    func time(for target: CMTime) -> CMTime {
        indexedFrames?.frame(closestTo: target) ?? target
    }

    private func resetIndexing() {
        indexer.cancel()
        indexedFrames = nil
    }

    private func indexFrames() {
        resetIndexing()

        guard providesFrameAccurateTiming,
              let asset = asset,
              indexedFrames == nil else { return }

        indexer.indexFrames(for: asset) { [weak self] result in
            switch result {
            case .failure:
                break  // Ignore silently for now.
            case .success(let indexedFrames):
                DispatchQueue.main.async {
                    self?.indexedFrames = indexedFrames
                }
            }
        }
    }
}
