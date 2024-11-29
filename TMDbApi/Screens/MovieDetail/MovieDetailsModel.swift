//
//  MovieDetailsModel.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation

// MARK: - MovieDetailsModel
struct MovieDetailsModel: Codable {
    let backdropPath: String
    let budget: Int
    let genres: [GenreModel]
    let homepage: String
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, title: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, title
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
