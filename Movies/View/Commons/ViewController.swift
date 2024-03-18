//
//  ViewController.swift
//  Movies
//
//  Created by Marta on 11/3/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .white
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func showLoading() {
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
    }
}
