//
//  NetworkManager.swift
//  CookBook
//
//  Created by Лаванда on 28.02.2023.
//

import UIKit

class NetworkManager {
    private let apiKey = "e61c6e1c1a21413492217141c55a118e"
    static let shared = NetworkManager()
    private init() {}
    
    func fetchRecipe (id: Int, with completion: @escaping(Recipe) -> Void) {
        let urlString  = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, responce, error in
           
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data, let _ = responce else {return}
            do{
                let recipe = try JSONDecoder().decode(Recipe.self, from: data)
                DispatchQueue.main.async {
                    completion(recipe)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func fetchAllCuizineRecipe (cuisine: String, with completion: @escaping(AllRecipes) -> Void) {
        let urlString = " https://api.spoonacular.com/recipes/complexSearch?cuisine=\(cuisine)&sort=popularity&number=20&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, responce, error in
           
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data, let _ = responce else {return}
            do{
                let allRecipes = try JSONDecoder().decode(AllRecipes.self, from: data)
                DispatchQueue.main.async {
                    completion(allRecipes)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    func fetchAllRecipesOfType (type: String, with completion: @escaping(AllRecipes) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?sort=popularity&number=20&type=\(type)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, responce, error in
           
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data, let _ = responce else {return}
            do{
                let allRecipes = try JSONDecoder().decode(AllRecipes.self, from: data)
                DispatchQueue.main.async {
                    completion(allRecipes)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func fetchAllRecipesOfHot (with completion: @escaping (AllRecipes) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?sort=popularity&number=20&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, responce, error in
           
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data, let _ = responce else {return}
            do{
                let allRecipes = try JSONDecoder().decode(AllRecipes.self, from: data)
                
                DispatchQueue.main.async {
                    completion(allRecipes)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func fetchDishesResipes (cuisine: String, with completion: @escaping (AllRecipes) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?cuisine=\(cuisine)&sort=popularity&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, responce, error in
           
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data, let _ = responce else {return}
            do{
                let allRecipes = try JSONDecoder().decode(AllRecipes.self, from: data)
                
                DispatchQueue.main.async {
                    completion(allRecipes)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
}
