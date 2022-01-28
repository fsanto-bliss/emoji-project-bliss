//
//  AppDelegate.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow!

    var coordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // create the main navigation controller to be used for our app
        let navController = UINavigationController()
        
        // send that into our coordinator so that it can display view controllers
        coordinator = Coordinator(navigationController: navController)
        
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        // create a basic UIWindow and activate it
        window.rootViewController = navController
        window.makeKeyAndVisible()

        return true
    }

}

