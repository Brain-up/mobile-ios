//
//  AppDelegate.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/14/22.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let filePath = Bundle.main.path(forResource: "GoogleService-Info_debug", ofType: "plist") ?? ""
        if let options = FirebaseOptions.init(contentsOfFile: filePath) {
            FirebaseApp.configure(options: options)
        } else {
            print("Firebase Config not found")
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        coordinator = AppCoordinator(navController)
        coordinator?.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

}
