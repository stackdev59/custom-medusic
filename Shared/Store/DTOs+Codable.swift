import Foundation

extension Album: Codable {
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case artistName
        case isFavorite
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.name = try container.decode(String.self, forKey: .name)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(artistName, forKey: .artistName)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}

extension Song: Codable {
    enum CodingKeys: String, CodingKey {
        case uuid
        case index
        case name
        case parentId
        case isFavorite
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.index = try container.decode(Int.self, forKey: .index)
        self.name = try container.decode(String.self, forKey: .name)
        self.parentId = try container.decode(String.self, forKey: .parentId)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(index, forKey: .index)
        try container.encode(name, forKey: .name)
        try container.encode(parentId, forKey: .parentId)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}
