//
//  AppRouterView.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import SwiftUI

struct AppRouterView<Content: View>: View {
    
    // MARK: - Properties
    
    @StateObject var appRouter: AppRouter = AppRouter()
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationStack(path: $appRouter.path) {
            content
                .navigationDestination(for: AppRouter.Route.self) { route in
                    appRouter.view(for: route)
                }
        }
        .environmentObject(appRouter)
    }
}
