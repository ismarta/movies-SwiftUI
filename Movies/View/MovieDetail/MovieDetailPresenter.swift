//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Marta on 13/3/24.
//

import Foundation
import Combine


class MovieDetailPresenter {
    private weak var ui: MovieDetailUI?
    var movie: Movie
    var saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase
    var deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase
    var favoriteStatusDelegate: FavoriteStatusDelegate?
    var cancellables: Set<AnyCancellable> = []

    init(ui: MovieDetailUI, movie: Movie, saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase, deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase) {
        self.ui = ui
        self.movie = movie
        self.saveFavoriteMovieUseCase = saveFavoriteMovieUseCase
        self.deleteFavoriteMovieUseCase = deleteFavoriteMovieUseCase
        self.movie = movie
    }

    func uiLoaded() {
        ui?.showDetails(movie: movie)
    }

    func favoriteButtonPressed(isSelected: Bool) {
        if isSelected {
            deleteFavoriteMovie(with: movie.identifier)
        } else {
            saveFavoriteMovie(movie)
        }
    }

    func uiClosed() {
        favoriteStatusDelegate?.didUpdateFavoriteState(for: movie)
    }

    private func saveFavoriteMovie(_ movie: Movie) {
        saveFavoriteMovieUseCase.execute(movie: movie).sink(receiveCompletion:  {[weak self] completion in
            switch completion {
            case .finished:
                print("saveFavoriteUseCase::Success")
            case .failure(let error):
                print("saveFavoriteUseCase::Error: \(error)")
                DispatchQueue.main.async {
                    self?.ui?.hideLoading()
                }
            }
        }, receiveValue: {[weak self] saved in
            if saved {
                self?.movie.isFavorite = true
                DispatchQueue.main.async {
                    self?.ui?.updateFavoriteButton()
                }
            }
        }).store(in: &cancellables)
    }

    private func deleteFavoriteMovie(with id: Int) {
        deleteFavoriteMovieUseCase.execute(idMovie: id).sink(receiveCompletion:  { [weak self] completion in
            switch completion {
            case .finished:
                print("deleteFavoriteMovieUseCase::Success")
            case .failure(let error):
                print("deleteFavoriteMovieUseCase::Error::\(error)")
                DispatchQueue.main.async {
                    self?.ui?.hideLoading()
                }
            }
        }, receiveValue: { [weak self] saved in
            if saved {
                self?.movie.isFavorite = false
                DispatchQueue.main.async {
                    self?.ui?.updateFavoriteButton()
                }
            }
        }).store(in: &cancellables)
    }
}


protocol MovieDetailUI: UI {
    func showDetails(movie: Movie)
    func updateFavoriteButton()
}
