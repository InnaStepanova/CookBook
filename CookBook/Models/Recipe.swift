//
//  Recipe.swift
//  CookBook
//
//  Created by Лаванда on 27.02.2023.
//

import Foundation

// MARK: - Recipe
struct Recipe: Decodable {
    let cookingMinutes: Int?
    let pricePerServing: Double?
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let image: String?
    let instructions: String?
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Decodable {
    let  original: String?
}
