//
//  Resources.swift
//  CookBook
//
//  Created by Лаванда on 27.02.2023.
//

import UIKit

enum Resources {
    
    enum Colors {
        static let red = UIColor(red: 0.886, green: 0.243, blue: 0.243, alpha: 1)
        static let pink = UIColor(red: 0.953, green: 0.698, blue: 0.698, alpha: 1)
    }
    
    enum Image {
        enum TabBar {
            static let main = UIImage(systemName: "fork.knife.circle")
            static let search = UIImage(systemName: "magnifyingglass.circle")
            static let cuisine = UIImage(systemName: "globe.central.south.asia")
            static let favourites = UIImage(systemName: "heart.fill")
            static let toDoList = UIImage(systemName: "cart.circle")
        }
        static let defaultImage = UIImage(named: "cheaf")
    }
    
    enum Strings {
        static let veg = "vegetarian"
        enum TabBar {
            static let main = "Main"
            static let search = "Search"
            static let cuisine = "Cuisine"
            static let favourites = "Favourites"
            static let toDoList = "ToDo"
        }
    }
}
