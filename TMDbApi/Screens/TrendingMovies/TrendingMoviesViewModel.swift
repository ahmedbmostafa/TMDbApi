//
//  TrendingMoviesViewModel.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import Combine

class TrendingMoviesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var genres: [GenreModel] = []
    @Published var trendingMovies: [TrendingMovieModel] = []
    @Published var searchResults: [TrendingMovieModel] = []
    @Published var filteredMovies: [TrendingMovieModel] = []
    @Published var searchText: String = ""
    @Published var placeholderSearchValue = "Search TMDB"
    @Published var isSearching = false
    @Published var selectedGenreID: Int? = nil
    @Published var pageNumber = 1
    @Published var isPagination = true
    private let responsePerPage = 10
    let cacheManager: CacheManager!
    private let genresCacheKey = "genres"
    private let trendingMoviesCacheKey = "trendingMovies"
    private let trendingMoviesService: TrendingMoviesServiceable
    private var cancellables = Set<AnyCancellable>()
    
    init(trendingMoviesService: TrendingMoviesServiceable = TrendingMoviesService(), cacheManager: CacheManager = CacheManager()) {
        self.trendingMoviesService = trendingMoviesService
        self.cacheManager = cacheManager
    }
    
    func onAppear() {
        resetFlags()
        loadCachedGenres()
        loadCachedMovies()
    }
}

// MARK: - Genres

extension TrendingMoviesViewModel {
    private func loadCachedGenres() {
        if let cachedGenres = cacheManager.loadFromCache(forKey: genresCacheKey, as: [GenreModel].self) {
            genres = cachedGenres
            print("genres=", genres.count)
            print("cachedGenres")
        } else {
            getGenres()
        }
    }
    
    private func getGenres() {
        let response: AnyPublisher<GenresModel, APIError> = trendingMoviesService.getGenres()
        response
            .sink(receiveCompletion: onReceiveFailure, receiveValue: onReceiveGenresModelResponse)
            .store(in: &cancellables)
    }
    
    private func onReceiveFailure(_ completion: Subscribers.Completion<APIError>) {
        if case let .failure(error) = completion {
            print("err=",error)
        }
    }
    
    private func onReceiveGenresModelResponse(_ response: GenresModel) {
        let data = response.genres
        genres = data
        cacheManager.saveToCache(genres, forKey: genresCacheKey)
        print("genres=", genres.count)
    }
}

// MARK: - TrendingMovies

extension TrendingMoviesViewModel {
    func loadMoreMovies(currentMovie: TrendingMovieModel) {
        guard trendingMovies.count >= responsePerPage else { return }
        guard let index = trendingMovies.firstIndex(where: { $0.id == currentMovie.id }) else { return }
        if index == trendingMovies.count - 10 && isPagination {
            let uniqueMovies = trendingMovies.uniqued(by: \.id)
            let calculatedPage = (uniqueMovies.count + responsePerPage - 1) / responsePerPage
            if pageNumber < calculatedPage {
                pageNumber += 1
                getTrendingMovies()
            }
        }
    }
    
    private func loadCachedMovies() {
           if let cachedMovies = cacheManager.loadFromCache(forKey: trendingMoviesCacheKey, as: [TrendingMovieModel].self) {
               trendingMovies = cachedMovies.uniqued(by: \.id)
               updateFilteredMovies()
               print("trendingMovies=", trendingMovies.count)
               print("cachedMovies")
           } else {
               getTrendingMovies()
           }
       }
    
    private func getTrendingMovies() {
        let response: AnyPublisher<TrendingMoviesModel, APIError> = trendingMoviesService.getTrendingMovies(page: pageNumber)
        response
            .sink(receiveCompletion: onReceiveFailure, receiveValue: onReceiveTrendingMoviesModelResponse)
            .store(in: &cancellables)
    }
    
    private func onReceiveTrendingMoviesModelResponse(_ response: TrendingMoviesModel) {
        let data = response.results
        if data.count < responsePerPage {
            isPagination = false
        }
        trendingMovies += data
        trendingMovies = trendingMovies.uniqued(by: \.id)
        cacheManager.saveToCache(trendingMovies, forKey: trendingMoviesCacheKey)
        print("trendingMovies=", trendingMovies.count)
        updateFilteredMovies()
    }
}

extension TrendingMoviesViewModel {
    private func resetFlags() {
        pageNumber = 1
        isPagination = true
    }
    
    func updateFilteredMovies() {
        searchResults = []
        if searchText.isEmpty && selectedGenreID == nil {
            // No search or genre filter applied, show all movies
            searchResults = trendingMovies
        } else if !searchText.isEmpty && selectedGenreID == nil {
            // Search filter applied only
            searchResults = trendingMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        } else if searchText.isEmpty && selectedGenreID != nil {
            // Genre filter applied only
            searchResults = trendingMovies.filter { $0.genreIDS.contains(selectedGenreID!) }
        } else if let genreID = selectedGenreID {
            // Both search and genre filters applied
            searchResults = trendingMovies.filter { $0.genreIDS.contains(genreID) && $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}
