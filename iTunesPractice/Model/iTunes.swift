//
//  iTunes.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import Foundation

struct iTunesResponse: Decodable {
    let resultCount: Int
    let results: [AppResult]
}

struct AppResult: Decodable {
    let artworkUrl60: String?
    let screenshotUrls: [String]?
    let trackCensoredName: String?
    let artistName: String?
    let genres: [String]?
    let averageUserRating: Double?
}
