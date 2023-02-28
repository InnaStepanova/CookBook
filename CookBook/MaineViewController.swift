//
//  MaineViewController.swift
//  CookBook
//
//  Created by Лаванда on 28.02.2023.
//

import UIKit

class MaineViewController: UIViewController {
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchRecipe(from: URLs.recipe) { recipe in
            self.recipe = recipe
            print(self.recipe?.title ?? "No value")
            print(self.recipe?.instructions ?? "No value")
        }
    }
}
