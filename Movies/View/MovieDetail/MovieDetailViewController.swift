//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Marta on 13/3/24.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var presenter: MovieDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.uiLoaded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let navigationController = navigationController,
               navigationController.viewControllers.contains(self) == false {
            presenter?.uiClosed()
        }
    }
    
    private func customiseView(movie: Movie) {
        self.titleLabel.text = movie.title
        self.languageLabel.text = movie.originalLanguage
        overviewLabel.text = movie.overview
        favoriteButton.isSelected = movie.isFavorite
    }

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        presenter?.favoriteButtonPressed(isSelected: favoriteButton.isSelected)
    }
}

extension MovieDetailViewController: MovieDetailUI {
    func showDetails(movie: Movie) {
        customiseView(movie: movie)
    }

    func updateFavoriteButton() {
        favoriteButton.isSelected = !favoriteButton.isSelected
    }
}

