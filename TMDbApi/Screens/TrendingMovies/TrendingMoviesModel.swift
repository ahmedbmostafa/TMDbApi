//
//  TrendingMoviesModel.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import Foundation

// MARK: - GenresModel
struct GenresModel: Codable {
    let genres: [GenreModel]
}

// MARK: - GenreModel
struct GenreModel: Codable {
    let id: Int
    let name: String
}

extension GenreModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: GenreModel, rhs: GenreModel) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - TrendingMoviesModel
struct TrendingMoviesModel: Codable {
    let results: [TrendingMovieModel]
}

// MARK: - TrendingMovieModel
struct TrendingMovieModel: Codable, Identifiable {
    let id: Int
    let genreIDS: [Int]
    let releaseDate, title: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case genreIDS = "genre_ids"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

extension TrendingMovieModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: TrendingMovieModel, rhs: TrendingMovieModel) -> Bool {
        return lhs.id == rhs.id
    }
}
