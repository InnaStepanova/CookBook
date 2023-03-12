//
//  TabBarController.swift
//  CookBook
//
//  Created by Лаванда on 26.02.2023.
//

import UIKit

enum Tabs: Int {
    case main
    case search
    case cuisine
    case favourites
    case toDoList
}

class TabBarController: UITabBarController{
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = Resources.Colors.red
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        
        tabBar.layer.borderColor = Resources.Colors.red.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let mainViewController = AmazingViewController()
        let searchViewController = FavouritesVC()
        let cuizineCollectionViewController = WorldDishesViewController()
        let favoritesViewController = LikeRecipesViewController()
        let toDoListViewController = ToDoListViewController()
        
        let mainNavigation = UINavigationController(rootViewController: mainViewController)
        let searchNavigation = UINavigationController(rootViewController: searchViewController)
        let cuizineNavigation = UINavigationController(rootViewController: cuizineCollectionViewController)
        let favoritesNavigation = UINavigationController(rootViewController: favoritesViewController)
        let toDoListNavigation = UINavigationController(rootViewController: toDoListViewController)

        mainViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.main,
                                                     image: Resources.Image.TabBar.main,
                                                     tag: Tabs.main.rawValue)
        searchViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.search,
                                                       image: Resources.Image.TabBar.search,
                                                       tag: Tabs.search.rawValue)
        cuizineCollectionViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.cuisine,
                                                                  image: Resources.Image.TabBar.cuisine,
                                                                  tag: Tabs.cuisine.rawValue)
        favoritesViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.favourites,
                                                          image: Resources.Image.TabBar.favourites,
                                                          tag: Tabs.favourites.rawValue)
        toDoListViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.toDoList,
                                                         image: Resources.Image.TabBar.toDoList,
                                                         tag: Tabs.toDoList.rawValue)
        
        setViewControllers([
            mainNavigation,
            searchNavigation,
            cuizineNavigation,
            favoritesNavigation,
            toDoListNavigation
        ], animated: true)
    }
}

