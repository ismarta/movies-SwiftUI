//
//  BaseViewController.swift
//  Movies
//
//  Created by Marta on 13/3/24.
//

import Foundation
import UIKit

class BaseViewController: ViewController, RoutableViewController {
    var router: AppRouter?

    init(router: AppRouter?, nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.router = router
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
