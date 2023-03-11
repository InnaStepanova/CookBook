//
//  DataManager.swift
//  CookBook
//
//  Created by Лаванда on 09.03.2023.
//

import UIKit

class DataManager {
    static let shared = DataManager()
    private let userDefaults = UserDefaults.standard
    private let recipesKey = "RecipesKey"
    
    private init() {}
    
    func  save(recipe: Result) {
        var recipes = fetchRecipes()
        if !recipes.contains(recipe) {
           
            recipes.append(recipe)
            guard let data = try? JSONEncoder().encode(recipes) else {return}
            userDefaults.set(data, forKey: recipesKey)
        }
    }
    func  delete(recipe: Result) {
        var recipes = fetchRecipes()
        if let index = recipes.firstIndex(of: recipe) {
            recipes.remove(at: index)
        }
        
        guard let data = try? JSONEncoder().encode(recipes) else {return}
        userDefaults.set(data, forKey: recipesKey)
    }
    
    func fetchRecipes() -> [Result] {
        guard let data = userDefaults.object(forKey: recipesKey) as? Data else {return [] }
        guard let recipes = try? JSONDecoder().decode([Result].self, from: data) else {return [] }
        return recipes
    }
}
