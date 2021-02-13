import Photos

/// An album and its fetched album contents.
struct FetchedAlbum: FetchedAlbumProtocol {
    let assetCollection: PHAssetCollection
    let fetchResult: PHFetchResult<PHAsset>
}

// MARK: - Change Details

extension FetchedAlbum {

    /// Photo library change details for the album.
    struct ChangeDetails {

        /// nil if album was deleted.
        let albumAfterChanges: FetchedAlbum?

        /// nil if album did not change.
        let assetCollectionChanges: PHObjectChangeDetails<PHAssetCollection>?

        /// nil if album contents did not change.
        let fetchResultChanges: PHFetchResultChangeDetails<PHAsset>?
    }
}

// MARK: - Fetching Albums

extension FetchedAlbum {

    /// Fetches assets for the given album.
    static func fetchAssets(in assetCollection: PHAssetCollection, options: PHFetchOptions? = nil) -> FetchedAlbum {
        let fetchResult = PHAsset.fetchAssets(in: assetCollection, options: options)
        return FetchedAlbum(assetCollection: assetCollection, fetchResult: fetchResult)
    }

    /// For each type fetches the album and its contents.
    static func fetchSmartAlbums(with types: [PHAssetCollectionSubtype], assetFetchOptions: PHFetchOptions? = nil) -> [FetchedAlbum] {
        let albums = types.compactMap {
            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: $0, options: nil).firstObject
        }

        return albums.map { fetchAssets(in: $0, options: assetFetchOptions) }
    }
}
