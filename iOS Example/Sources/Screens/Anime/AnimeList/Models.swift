//
//  Models.swift
//  SwiftUIBlocExample
//
//  Created by Mehdok on 8/31/21.
//

import Foundation

// MARK: - AnimeListWrapper

struct AnimeListWrapper: Codable {
    let requestHash: String
    let requestCached: Bool
    let requestCacheExpiry: Int
    let results: [AnimeResult]
    let lastPage: Int

    enum CodingKeys: String, CodingKey {
        case requestHash = "request_hash"
        case requestCached = "request_cached"
        case requestCacheExpiry = "request_cache_expiry"
        case results
        case lastPage = "last_page"
    }
}

// MARK: - Result

struct AnimeResult: Codable, Equatable {
    let malID: Int
    let url: String?
    let imageURL: String?
    let title: String?
    let airing: Bool?
    let synopsis: String?
    let type: String?
    let episodes: Int?
    let score: Double?
    let startDate: String?
    let endDate: String?
    let members: Int?
    let rated: Rated?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url
        case imageURL = "image_url"
        case title, airing, synopsis, type, episodes, score
        case startDate = "start_date"
        case endDate = "end_date"
        case members, rated
    }

    static func == (lhs: AnimeResult, rhs: AnimeResult) -> Bool {
        lhs.malID == rhs.malID
    }
}

enum Rated: String, Codable {
    case g = "G"
    case pg = "PG"
    case pg13 = "PG-13"
    case r = "R"
    case ratedR = "R+"
    case rx = "Rx"
}

// enum TypeEnum: String, Codable {
//    case movie = "Movie"
//    case music = "Music"
//    case ona = "ONA"
//    case ova = "OVA"
//    case special = "Special"
//    case tv = "TV"
//    case unknown = "Unknown"
//    case manga = "Manga"
//    case anime = "Anime"
//    case lightNovel = "Light Novel"
//    case manhwa = "Manhwa"
//    case novel = "Novel"
//    case manhua = "Manhua"
//    case oneShot = "One-shot"
//    case doujinshi = "Doujinshi"
// }

// MARK: - AnimeDetail

struct AnimeDetail: Codable, Equatable {
    let requestHash: String?
    let requestCached: Bool?
    let requestCacheExpiry, malID: Int?
    let url: String?
    let imageURL: String?
    let trailerURL: String?
    let title, titleEnglish, titleJapanese: String?
    let titleSynonyms: [String]?
    let type, source: String?
    let episodes: Int?
    let status: String?
    let airing: Bool?
    let aired: Aired?
    let duration, rating: String?
    let score: Double?
    let scoredBy, rank, popularity, members: Int?
    let favorites: Int?
    let synopsis, background, premiered, broadcast: String?
    let related: Related?
    let producers, licensors, studios, genres: [Genre]?
    let openingThemes, endingThemes: [String]?

    enum CodingKeys: String, CodingKey {
        case requestHash = "request_hash"
        case requestCached = "request_cached"
        case requestCacheExpiry = "request_cache_expiry"
        case malID = "mal_id"
        case url
        case imageURL = "image_url"
        case trailerURL = "trailer_url"
        case title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, premiered, broadcast, related, producers, licensors, studios, genres
        case openingThemes = "opening_themes"
        case endingThemes = "ending_themes"
    }

    static func == (lhs: AnimeDetail, rhs: AnimeDetail) -> Bool {
        lhs.url == rhs.url
    }
}

// MARK: - Aired

struct Aired: Codable {
    let from, to: String?
    let prop: Prop?
    let string: String?
}

// MARK: - Prop

struct Prop: Codable {
    let from, to: From?
}

// MARK: - From

struct From: Codable {
    let day, month, year: Int?
}

// MARK: - Genre

struct Genre: Codable {
    let malID: Int
    let type: String?
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

// MARK: - Related

struct Related: Codable {
    let adaptation, sideStory, summary: [Genre]?

    enum CodingKeys: String, CodingKey {
        case adaptation = "Adaptation"
        case sideStory = "Side story"
        case summary = "Summary"
    }
}
