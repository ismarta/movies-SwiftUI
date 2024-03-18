//
//  RoutableViewController.swift
//  Movies
//
//  Created by Marta on 13/3/24.
//

import Foundation
import UIKit

protocol RoutableViewController: UIViewController {
    var router: AppRouter? { get set }
}
