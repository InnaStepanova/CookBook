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
    
    func save(recipe: Result) {
        var recipes = fetchRecipes()
        let recipesID = recipes.map { $0.id }
        if !recipesID.contains(recipe.id) {
            recipes.append(recipe)
            guard let data = try? JSONEncoder().encode(recipes) else {return}
            userDefaults.set(data, forKey: recipesKey)
        }
    }
    func delete(recipe: Result) {
        var recipes = fetchRecipes()
        let recipesID = recipes.map { $0.id }
        if let index = recipesID.firstIndex(of: recipe.id) {
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
    
    func isRecipeInFavorite(_ recipe: Result) -> Bool {
        let favorites = DataManager.shared.fetchRecipes()
        let recipesID = favorites.map { $0.id }
        return recipesID.contains(recipe.id) ? true : false
    }
    
    //MARK: - Ingredients
    private let ingredientsKey = "ingredientsKey"
    
    func save(ingredient: String) {
        var ingredients = fetchIngredients()
        if !ingredients.contains(ingredient) {
           
            ingredients.append(ingredient)
            guard let data = try? JSONEncoder().encode(ingredients) else {return}
            userDefaults.set(data, forKey: ingredientsKey)
        }
    }
    func delete(ingredient: String) {
        var ingredients = fetchIngredients()
        if let index = ingredients.firstIndex(of: ingredient) {
            ingredients.remove(at: index)
        }
        
        guard let data = try? JSONEncoder().encode(ingredients) else {return}
        userDefaults.set(data, forKey: ingredientsKey)
    }
    
    func fetchIngredients() -> [String] {
        guard let data = userDefaults.object(forKey: ingredientsKey) as? Data else {return [] }
        guard let recipes = try? JSONDecoder().decode([String].self, from: data) else {return [] }
        return recipes
    }
}
