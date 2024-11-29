//
//  MovieDetailView.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .top) {
                    KFImage(viewModel.movieBackImageValue)
                        .placeholder {
                            Image(viewModel.posterPlaceholderValue)
                                .resizable()
                                .frame(height: 300)
                                .clipped()
                                .contentShape(Rectangle())
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .clipped()
                        .contentShape(Rectangle())
                    
                    MovieDetailBackView()
                }
                
                HStack(alignment: .top, spacing: 0) {
                    KFImage(viewModel.movieImageValue)
                        .placeholder {
                            Image(viewModel.posterPlaceholderValue)
                                .resizable()
                                .frame(width: 80, height: 130)
                                .clipped()
                                .contentShape(Rectangle())
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 130)
                        .clipped()
                        .contentShape(Rectangle())
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(viewModel.movieTitleValue)
                            .font(.tmdbBold(16))
                            .foregroundColor(Color.whiteColor)
                            .lineLimit(2)
                        
                        Text("Genres: \(viewModel.movieGenresValue)")
                            .font(.tmdbRegular(12))
                            .foregroundColor(Color.whiteColor)
                            .lineLimit(3)
                        
                        Spacer()
                    }
                    .frame(height: 130)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 14, leading: 14, bottom: 0, trailing: 14))
                
                Text(viewModel.overviewValue)
                    .font(.tmdbBold(12))
                    .foregroundColor(Color.whiteColor)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
                
                Spacer()
                
                HStack {
                    Text("Homepage: ")
                        .font(.tmdbBold(12))
                        .foregroundColor(Color.whiteColor)
                    
                    if let homepage = viewModel.homepageValue  {
                        Link("\(homepage)", destination: homepage)
                            .font(.tmdbRegular(12))
                            .foregroundColor(.blue)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                HStack {
                    Text("Language: ")
                        .font(.tmdbBold(12))
                        .foregroundColor(Color.whiteColor)
                    
                    Text(viewModel.spokenLanguagesValue)
                        .font(.tmdbRegular(12))
                        .foregroundColor(Color.whiteColor)
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Status: ")
                                .font(.tmdbBold(12))
                                .foregroundColor(Color.whiteColor)
                            
                            Text(viewModel.statusValue)
                                .font(.tmdbRegular(12))
                                .foregroundColor(Color.whiteColor)
                        }
                        
                        HStack {
                            Text("Budget: ")
                                .font(.tmdbBold(12))
                                .foregroundColor(Color.whiteColor)
                            
                            Text(viewModel.budgetValue)
                                .font(.tmdbRegular(12))
                                .foregroundColor(Color.whiteColor)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Runtime: ")
                                .font(.tmdbBold(12))
                                .foregroundColor(Color.whiteColor)
                            
                            Text("\(viewModel.runTimeValue) min")
                                .font(.tmdbRegular(12))
                                .foregroundColor(Color.whiteColor)
                        }
                        
                        HStack {
                            Text("Revenue: ")
                                .font(.tmdbBold(12))
                                .foregroundColor(Color.whiteColor)
                            
                            Text(viewModel.revenueValue)
                                .font(.tmdbRegular(12))
                                .foregroundColor(Color.whiteColor)
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            }
            
            if viewModel.isLoading {
                Color.cardColor
            }
        }
        .background(.black)
        .navigationBarBackButtonHidden(true)
        
    }
}

// MARK: - MovieDetailBackView

struct MovieDetailBackView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appRouter: AppRouter
    
    // MARK: - Body
    
    var body: some View {
        
        HStack(alignment: .center) {
            Image("back_white")
                .frame(width: 12, height: 24)
                .padding(.leading, 20)
                .onTapGesture {
                    appRouter.navigateBack()
                }
            
            Spacer()
        }
        .frame(height: 48)
        .background(.black.opacity(0.25))
    }
}
