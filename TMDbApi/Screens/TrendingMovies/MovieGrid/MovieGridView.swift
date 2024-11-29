//
//  MovieGridView.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import SwiftUI
import Kingfisher

struct MovieGridView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var viewModel: MovieGridViewModel
    var gridItemLayoutSingle = [GridItem(.flexible(), spacing: 0)]
    
    // MARK: - Body
    
    var body: some View {
        
        LazyVGrid(columns: gridItemLayoutSingle, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                if viewModel.movieImageValue != nil {
                    KFImage(viewModel.movieImageValue)
                        .placeholder {
                            Image(viewModel.posterPlaceholderValue)
                                .resizable()
                                .frame(height: 250)
                                .clipped()
                                .contentShape(Rectangle())
                        }
                        .resizable()
                        .frame(height: 250)
                        .clipped()
                        .contentShape(Rectangle())
                }
                
                Spacer()
                
                Text(viewModel.movieTitleValue)
                    .font(.tmdbBold(16))
                    .foregroundColor(Color.whiteColor)
                    .lineLimit(2)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                Text(viewModel.releaseYearValue)
                    .font(.tmdbSemiBold(10))
                    .foregroundColor(Color.whiteColor)
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
                
                Spacer()
            }
            .frame(height: 350)
            .background(Color.cardColor)
            .padding(.bottom, 20)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
        .background(.clear)
        
    }
}
