//
//  TrendingMoviesView.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import SwiftUI

struct TrendingMoviesView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var viewModel: TrendingMoviesViewModel
    let trendingMoviesColumns = [GridItem(.flexible(), spacing: -8), GridItem(.flexible(), spacing: -8)]
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(spacing: 0) {
            SearchHeaderView()
                .environmentObject(viewModel)
            
            ScrollView {
                LazyVGrid(columns: trendingMoviesColumns, spacing: 0) {
                    ForEach(viewModel.searchResults) { movie in
                        MovieGridView()
                            .environmentObject(viewModel)
                            .environmentObject(MovieGridViewModel(movie: movie))
                            .onAppear {
                                viewModel.loadMoreMovies(currentMovie: movie)
                            }
                            .onTapGesture {
                                appRouter.navigateTo(.movieDetails(movieID: movie.id))
                            }
                    }
                }
            }
            .refreshable {
                viewModel.onAppear()
            }
        }
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.onAppear()
        }
        
    }
}

// MARK: - SearchHeaderView

struct SearchHeaderView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var trendingMoviesViewModel: TrendingMoviesViewModel
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                        if trendingMoviesViewModel.searchText.isEmpty && !trendingMoviesViewModel.isSearching {
                            Text(trendingMoviesViewModel.placeholderSearchValue)
                                .font(.tmdbRegular(12))
                                .foregroundColor(Color.textGray)
                        }
                        
                        TextField("", text: $trendingMoviesViewModel.searchText)
                            .font(.tmdbRegular(16))
                            .autocorrectionDisabled(true)
                            .foregroundColor(Color.whiteColor)
                            .submitLabel(.done)
                            .onTapGesture {
                                trendingMoviesViewModel.isSearching = true
                            }
                    }
                    
                    Spacer()
                    
                    if trendingMoviesViewModel.isSearching {
                        Image("close_button")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
                            .onTapGesture {
                                hideKeyboard()
                                trendingMoviesViewModel.searchText = ""
                                trendingMoviesViewModel.isSearching = false
                            }
                    }
                }
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .background(Color.searchBarColor)
            }
            .padding(.top, 1)
            
            Text("Watch New Movies")
                .font(.tmdbBlackBold(26))
                .foregroundColor(Color.yellowColor)
                .padding(EdgeInsets(top: 14, leading: 20, bottom: 0, trailing: 0))
            
            GenresScrollView()
                .environmentObject(trendingMoviesViewModel)
                .padding(EdgeInsets(top: 14, leading: 8, bottom: 14, trailing: 0))
        }
        .onChange(of: trendingMoviesViewModel.searchText) { searchText in
            if searchText != "" {
                trendingMoviesViewModel.isSearching = true
            }
            trendingMoviesViewModel.updateFilteredMovies()
        }
        .onReceive(trendingMoviesViewModel.$isSearching) { isSearching in
            trendingMoviesViewModel.placeholderSearchValue = "Search TMDB"
        }
        
    }
}

// MARK: - GenresScrollView

struct GenresScrollView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var trendingMoviesViewModel: TrendingMoviesViewModel
    @State private var selectedCategoryIndex = -1
    
    // MARK: - Body
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(trendingMoviesViewModel.genres.indices, id: \.self) { index in
                        Text(trendingMoviesViewModel.genres[index].name)
                            .font(.tmdbRegular(16))
                            .foregroundColor((selectedCategoryIndex == index) ? Color.blackColor : Color.whiteColor)
                            .padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                            .background((selectedCategoryIndex == index) ? Color.yellowColor : Color.clear)
                            .frame(height: 28)
                            .clipShape(Capsule())
                            .id(selectedCategoryIndex)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.yellowColor, lineWidth: (selectedCategoryIndex != index) ? 1 : 0)
                            )
                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 6))
                            .onTapGesture {
                                if selectedCategoryIndex == index {
                                    selectedCategoryIndex = -1
                                    trendingMoviesViewModel.selectedGenreID = nil
                                } else {
                                    selectedCategoryIndex = index
                                    trendingMoviesViewModel.selectedGenreID = trendingMoviesViewModel.genres[index].id
                                }
                                trendingMoviesViewModel.updateFilteredMovies()
                                withAnimation {
                                    proxy.scrollTo(index, anchor: .center)
                                }
                            }
                    }
                }
            }
        }
        
    }
}
