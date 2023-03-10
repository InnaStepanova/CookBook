//
//  WorldDishesViewController.swift
//  CookBook
//
//  Created by Эдгар Исаев on 28.02.2023.
//

import UIKit

protocol DishesCollectionDelegate {
    func presentVC(dishes: String)
}

class WorldDishesViewController: UIViewController {
    
    private let dishesCollection = WorldDishesCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dishes of the World"
        tabBarItem.title = "Cuisines"
        setupViews()
        setConstraints()
        dishesCollection.delegate2 = self
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(dishesCollection)
    }
}

extension WorldDishesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            dishesCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dishesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dishesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dishesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension WorldDishesViewController: DishesCollectionDelegate {
    func presentVC(dishes: String) {
        
        let favoritesVC = FavouritesVC()
        NetworkManager.shared.fetchRecipes(parametr: dishes, typeOfRequest: .cuisine, offset: 0) { recipes in
            favoritesVC.allRecipes = recipes.results
        }
        favoritesVC.typeOfRequest = .cuisine
        favoritesVC.parametr = dishes
        favoritesVC.title = "Dishes of \(dishes)"
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
}
