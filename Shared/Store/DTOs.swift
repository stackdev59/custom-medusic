import Foundation
import JellyfinAPI

public struct JellyfinServerInfo {
    public var name: String
    public var version: String
}

public struct Album {

    public var uuid: String
    public var name: String
    public var artistName: String
    public var isDownloaded: Bool
    public var isFavorite: Bool
    public var songs: [Song]

    public init(
        uuid: String,
        name: String,
        artistName: String,
        isDownloaded: Bool,
        isFavorite: Bool,
        songs: [Song] = []
    ) {
        self.uuid = uuid
        self.name = name
        self.artistName = artistName
        self.isDownloaded = isDownloaded
        self.isFavorite = isFavorite
        self.songs = songs
    }

    public init(from item: BaseItemDto) {
        self.isDownloaded = false

        if let albumId = item.id {
            self.uuid = albumId
        } else {
            self.uuid = ""
        }

        if let albumName = item.name {
            self.name = albumName
        } else {
            self.name = ""
        }

        if let name = item.albumArtist {
            self.artistName = name
        } else {
            self.artistName = ""
        }

        if let isFavorite = item.userData?.isFavorite {
            self.isFavorite = isFavorite
        } else {
            self.isFavorite = false
        }

        self.songs = []
    }
}


public struct Song {

    public var uuid: String
    public var index: Int
    public var name: String
    public var parentId: String
    public var isDownloaded: Bool
    public var isFavorite: Bool

    public init(
        uuid: String,
        index: Int,
        name: String,
        parentId: String,
        isDownloaded: Bool,
        isFavorite: Bool
    ) {
        self.uuid = uuid
        self.index = index
        self.name = name
        self.parentId = parentId
        self.isDownloaded = isDownloaded
        self.isFavorite = isFavorite
    }

    public init(from item: BaseItemDto) {
        self.isDownloaded = false

        if let songId = item.id {
            self.uuid = songId
        } else {
            self.uuid = ""
        }

        if let index = item.indexNumber {
            self.index = Int(index)
        } else {
            self.index = 0
        }

        if let songName = item.name {
            self.name = songName
        } else {
            self.name = ""
        }

        if let parentId = item.parentID {
            self.parentId = parentId
        } else {
            self.parentId = ""
        }

        if let isFavorite = item.userData?.isFavorite {
            self.isFavorite = isFavorite
        } else {
            self.isFavorite = false
        }
    }
}
