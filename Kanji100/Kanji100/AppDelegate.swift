//
//  AppDelegate.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let screenFrame = UIScreen.main.bounds
        window = UIWindow(frame: screenFrame)
        let favoriteManager = FavoriteManager()
        
        let mainScreenViewController = MainScreenViewController(favoriteManager: favoriteManager)
        let favoriteScreenViewController = FavoriteScreenViewController(favoriteManager: favoriteManager)
        
        let mainScreenNavigationController = UINavigationController(rootViewController: mainScreenViewController)
        let favoriteScreenNavigationController = UINavigationController(rootViewController: favoriteScreenViewController)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainScreenNavigationController, favoriteScreenNavigationController]
        tabBarController.selectedViewController = mainScreenNavigationController
        
        let MainScreenTabBarItem = UITabBarItem(title: "All Kanjis", image: UIImage(systemName: "book.fill"), tag: 0)
        let favoriteScreenTabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        mainScreenNavigationController.tabBarItem = MainScreenTabBarItem
        favoriteScreenNavigationController.tabBarItem = favoriteScreenTabBarItem
        
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}
