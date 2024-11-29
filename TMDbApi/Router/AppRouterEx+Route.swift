//
//  AppRouterEx+Route.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import Foundation

extension AppRouter {
    enum Route: Hashable {
        
        // MARK: - Home
        case trendingMovies
        
        // MARK: - MovieDetail
        case movieDetails(movieID: Int)
    }
}
