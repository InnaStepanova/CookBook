//
//  SceneDelegate.swift
//  CookBook
//
//  Created by Лаванда on 26.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//         let tabBar = TabBarController()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = FavouritesVC()
        window?.makeKeyAndVisible()
        
    }
}

