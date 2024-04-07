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
    let artistViewURL: String
    let currentVersionReleaseDate: Date
    let releaseNotes: String
    let artistName: String
    let genres: [String]
    let trackName, description: String
    let averageUserRating: Double
    let userRatingCount: Int
}
