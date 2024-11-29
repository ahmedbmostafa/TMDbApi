//
//  AppRouterEx+ViewBuilder.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import SwiftUI

extension AppRouter {
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
            
            // MARK: - Home
        case .trendingMovies:
            TrendingMoviesView()
                .environmentObject(trendingMoviesViewModel)
            
            // MARK: - MovieDetail
        case .movieDetails(let movieID):
            MovieDetailsView()
                .environmentObject(MovieDetailsViewModel(movieID: movieID))
        }
    }
}
