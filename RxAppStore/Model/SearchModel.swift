//
//  SearchModel.swift
//  RxAppStore
//
//  Created by 이재희 on 4/7/24.
//

import Foundation

struct SearchModel: Decodable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let screenshotUrls: [String]
    let artworkUrl512: String
    let currentVersionReleaseDate: String
    let releaseNotes: String?
    let artistName: String
    let genres: [String]
    let trackName, description: String
    let averageUserRating: Double
    let version: String
    let userRatingCount: Int
    
    let mainGenre: String
    let convertedRatingCount: String
    let appIconUrl: URL
    
    enum CodingKeys: CodingKey {
        case screenshotUrls
        case artworkUrl512
        case currentVersionReleaseDate
        case releaseNotes
        case artistName
        case genres
        case trackName
        case description
        case averageUserRating
        case version
        case userRatingCount
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.screenshotUrls = try container.decode([String].self, forKey: .screenshotUrls)
        self.artworkUrl512 = try container.decode(String.self, forKey: .artworkUrl512)
        self.currentVersionReleaseDate = try container.decode(String.self, forKey: .currentVersionReleaseDate)
        self.releaseNotes = try container.decodeIfPresent(String.self, forKey: .releaseNotes) ?? ""
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.description = try container.decode(String.self, forKey: .description)
        self.averageUserRating = try container.decode(Double.self, forKey: .averageUserRating)
        self.version = "버전 " + (try container.decode(String.self, forKey: .version))
        self.userRatingCount = try container.decode(Int.self, forKey: .userRatingCount)
        self.mainGenre = genres.first ?? ""
        self.convertedRatingCount = userRatingCount.convertRatingCount()
        self.appIconUrl = URL(string: artworkUrl512)!
    }
    

}

extension Int {
    func convertRatingCount() -> String {
        if self >= 10000 {
            let num = Double(self) / 10000.0
            return "\(String(format: "%.1f", num))만"
        } else if self >= 1000 {
            let num = Double(self) / 1000.0
            return "\(String(format: "%.1f", num))천"
        }
        return "\(self)"
    }
}
