import Boutique
import Foundation

final class AlbumRepository: ObservableObject {
    static let shared = AlbumRepository(store: .albums)

    @Stored
    private var albums: [Album]

    private var api: ApiClient

    init(store: Store<Album>) {
        self._albums = Stored(in: store)
        self.api = ApiClient()
    }

    /// Refresh the store data with data from service.
    func refresh() async throws {
        let _ = try await self.api.performAuth()
        let remoteAlbums = try await self.api.services.albumService.simple_getAlbums()
        try await self.$albums.removeAll().insert(remoteAlbums).run()
    }

    /// Get all albums.
    func getAlbums() async -> [Album] {
        return await self.$albums.items
    }

    /// Get a specific album form store by its ID.
    func getAlbum(by albumId: String) async -> Album? {
        return await self.$albums.items.first { $0.uuid == albumId }
    }

    /// Get all favorite albums.
    func getFavorite() async -> [Album] {
        return await self.$albums.items.filter { $0.isFavorite }
    }
}

enum AlbumRepositoryError: Error {
    case notFound
}
