//
//  NetworkManager.swift
//  CookBook
//
//  Created by Лаванда on 28.02.2023.
//

import UIKit

enum TypeOfRequest {
    case search
    case cuisine
    case type
    case hot
}

class NetworkManager {

    private let apiKey = "da958c9edbb34fa48a1b181fbf6c3277"

    static let shared = NetworkManager()
    private init() {}
    
    func fetchRecipes (parametr: String, typeOfRequest: TypeOfRequest, offset: Int, with completion: @escaping(AllRecipes) -> Void) {
        
        var urlString = ""
        
        switch typeOfRequest {
        case .search:
            urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(parametr.replacingOccurrences(of: " ", with: "+"))&apiKey=\(apiKey)&number=30&offset=\(offset)"
        case .cuisine:
            urlString = "https://api.spoonacular.com/recipes/complexSearch?cuisine=\(parametr.replacingOccurrences(of: " ", with: "+"))&sort=popularity&number=20&apiKey=\(apiKey)&offset=\(offset)"
        case .type:
            urlString = "https://api.spoonacular.com/recipes/complexSearch?sort=popularity&number=20&type=\(parametr.replacingOccurrences(of: " ", with: "+"))&apiKey=\(apiKey)&offset=\(offset)"
        case .hot:
            urlString = "https://api.spoonacular.com/recipes/complexSearch?sort=popularity&number=20&apiKey=\(apiKey)&offset=\(offset)"
        }
        
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
}
