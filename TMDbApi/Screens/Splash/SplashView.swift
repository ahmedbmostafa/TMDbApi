//
//  SplashView.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import SwiftUI

struct SplashView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appRouter: AppRouter
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack(alignment: .center) {
            Color.cardColor
            
            Image("logo_")
        }
        .ignoresSafeArea()
        .task {
            await makeDelay(seconds: 1)
        }
    }
    
    private func makeDelay(seconds: Int) async {
        await delay(seconds: seconds) {
            handleCurrentRoot()
        }
    }

    private func handleCurrentRoot() {
        appRouter.navigateTo(.trendingMovies)
    }
}
