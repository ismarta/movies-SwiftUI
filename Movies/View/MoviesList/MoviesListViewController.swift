//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Marta on 6/3/24.
//

import UIKit                                                           
import Combine
import SwiftUI

protocol FavoriteStatusDelegate {
    func didUpdateFavoriteState(for movie: Movie)
}

class MoviesListViewController: BaseViewController  {
    var viewModel: MoviesListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        customise()
        setupHostedView()
    }

    private func setupHostedView() {
        guard let viewModel = viewModel else { return }
        let swiftUIHostingController = UIHostingController(rootView: MoviesView(viewModel: viewModel))
        swiftUIHostingController.view.backgroundColor = .black
        swiftUIHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        swiftUIHostingController.view.isOpaque = false
        addChild(swiftUIHostingController)
        view.addSubview(swiftUIHostingController.view)
        swiftUIHostingController.didMove(toParent: self)
        NSLayoutConstraint.activate([
            swiftUIHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftUIHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            swiftUIHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

    private func customise() {
        title = "MOVIES"
    }
}
