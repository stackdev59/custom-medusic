import Foundation
import JellyfinAPI

final class DummySongService: SongService {
    private let songs: [Song]

    init(songs: [Song]) {
        self.songs = songs
    }

    func getSongs(with userId: String) async throws -> [Song] {
        return self.songs
    }

    func getSongs(with userId: String, for albumId: String) async throws -> [Song] {
        return self.songs.filter { $0.parentId == albumId }
    }
}
