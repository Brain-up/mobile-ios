//
//  AppDelegate.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/14/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        coordinator = AppCoordinator(navController)
        coordinator?.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

}
