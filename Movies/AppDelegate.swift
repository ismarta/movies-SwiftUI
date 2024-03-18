//
//  AppDelegate.swift
//  Movies
//
//  Created by Marta on 6/3/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard normalExecutionPath() else {
            window = nil
            return false
        }
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = UIColor.black
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        let appRouter = AppRouter(navigationController: navigationController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appRouter.showInitialScreen()
        return true
    }

}

private func normalExecutionPath() -> Bool {
    return NSClassFromString("XCTestCase") == nil
}
