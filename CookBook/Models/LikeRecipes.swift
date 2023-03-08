//
//  LikeRecipes.swift
//  CookBook
//
//  Created by Лаванда on 28.02.2023.
//

import UIKit

struct LikeRecipes {
    var recipes: Set <Result> = []
    
    mutating func like(result: Result) {
        if let _ = result.like {
            recipes.insert(result)
        } else {
            recipes.remove(result)
        }
    }
}
