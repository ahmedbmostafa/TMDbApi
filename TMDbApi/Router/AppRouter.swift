//
//  AppRouter.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import SwiftUI
import Combine

var isNavigationDisabled = true

class AppRouter: ObservableObject {
   
    // MARK: - Properties

    @ObservedObject var trendingMoviesViewModel = TrendingMoviesViewModel()
    @Published var path: NavigationPath = NavigationPath()
    
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
