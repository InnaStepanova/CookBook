//
//  AllRecipes.swift
//  CookBook
//
//  Created by Лаванда on 27.02.2023.
//

import Foundation

struct AllRecipes: Decodable {
    let results: [Result]
    let offset, number, totalResults: Int
}

// MARK: - Result
struct Result: Decodable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}



