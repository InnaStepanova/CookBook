//
//  NetworkManager.swift
//  CookBook
//
//  Created by Лаванда on 28.02.2023.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchRecipe (from urlString: String, with completion: @escaping(Recipe) -> Void) {
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
    
    func fetchAllRecipe (from urlString: String, with completion: @escaping(AllRecipes) -> Void) {
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
