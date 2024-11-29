//
//  TMDbApiApp.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 27/11/2024.
//

import SwiftUI

@main
struct TMDbApiApp: App {
    var body: some Scene {
        WindowGroup {
            AppRouterView {
                SplashView()
            }
        }
    }
}
