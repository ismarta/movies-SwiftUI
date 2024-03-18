//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Marta on 15/3/24.
//

import Foundation
import Combine

enum StatusView: Equatable {
    case loading
    case error(String, String?)
    case success
}

class MoviesListViewModel: ObservableObject {
    var saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase
    var deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase
    var getTrendingMoviesWithFavoriteStatusUseCase: GetTrendingMoviesWithFavoriteStatusUseCase
    var router: AppRouter?
    var cancellables: Set<AnyCancellable> = []
    @Published var movies: [Movie]  = []
    @Published var statusView: StatusView
    static let emptyViewMessage = "No hay resultados"
    static let errorViewMessage = "Ha ocurrido un error"
    static let retryButtonText = "Volver a intentar"

    init(router: AppRouter, getTrendingMoviesWithFavoriteStatusUseCase: GetTrendingMoviesWithFavoriteStatusUseCase, saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase, deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase){
        self.getTrendingMoviesWithFavoriteStatusUseCase = getTrendingMoviesWithFavoriteStatusUseCase
        self.saveFavoriteMovieUseCase = saveFavoriteMovieUseCase
        self.deleteFavoriteMovieUseCase = deleteFavoriteMovieUseCase
        self.router = router
        statusView = .loading
        loadMovies()
    }

    func loadMovies() {
        let cancelable = getTrendingMoviesWithFavoriteStatusUseCase.execute().receive(on: DispatchQueue.main) .sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                print("GetTrendingMoviesWithFavoriteStatusUseCase::success")
            case .failure(let error):
                print("GetTrendingMoviesWithFavoriteStatusUseCase::Error: \(error)")
                self?.statusView = .error(MoviesListViewModel.errorViewMessage, MoviesListViewModel.retryButtonText)
            }
        }, receiveValue: {[weak self] movies in
            self?.movies = movies
            if movies.isEmpty {
                self?.statusView = .error(MoviesListViewModel.emptyViewMessage, nil)
            } else {
                self?.statusView = .success
            }
        })
        cancelable.store(in: &cancellables)
    }

    func favoriteButtonPressed(for movie: Movie, isFavorite: Bool) {
        if isFavorite {
            deleteFavoriteMovie(with: movie.identifier)
        } else {
            saveFavoriteMovie(movie)
        }
    }

    func moviePressed(movie: Movie) {
        router?.showMovieDetailScreen(with: movie, favoriteStatusDelegate: self)
    }

    private func saveFavoriteMovie(_ movie: Movie) {
        saveFavoriteMovieUseCase.execute(movie: movie).sink(receiveCompletion:  {completion in
            switch completion {
            case .finished:
                print("saveFavoriteUseCase::Success")
            case .failure(let error):
                print("saveFavoriteUseCase::Error: \(error)")
            }
        }, receiveValue: { [weak self] saved in
            if saved {
                self?.updateMovieList(with: movie.identifier, isFavorite: true)
            }
        }).store(in: &cancellables)
    }

    private func deleteFavoriteMovie(with id: Int) {
        deleteFavoriteMovieUseCase.execute(idMovie: id).sink(receiveCompletion:  { completion in
            switch completion {
            case .finished:
                print("deleteFavoriteMovieUseCase::Success")
            case .failure(let error):
                print("deleteFavoriteMovieUseCase::Error::\(error)")
            }
        }, receiveValue: { [weak self] saved in
            if saved {
                self?.updateMovieList(with: id, isFavorite: false)
            }
        }).store(in: &cancellables)
    }

    private func updateMovieList(with identifier: Int, isFavorite: Bool) {
        guard let index = movies.firstIndex(where: { $0.identifier == identifier }) else {
            return
        }
        if movies[index].isFavorite != isFavorite {
            DispatchQueue.main.async {
                self.movies[index].isFavorite = isFavorite
            }
        }
    }
}

extension MoviesListViewModel: FavoriteStatusDelegate {
    func didUpdateFavoriteState(for movie: Movie) {
        updateMovieList(with: movie.identifier, isFavorite: movie.isFavorite)
    }
}
