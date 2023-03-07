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
    
    private let worldDishesLabel: UILabel = {
       let label = UILabel()
        label.text = "Dishes of the world"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
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
        
        view.addSubview(worldDishesLabel)
        view.addSubview(dishesCollection)
    }
    
}


extension WorldDishesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            worldDishesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            worldDishesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            dishesCollection.topAnchor.constraint(equalTo: worldDishesLabel.bottomAnchor, constant: 5),
            dishesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dishesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dishesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension WorldDishesViewController: DishesCollectionDelegate {
    func presentVC(dishes: String) {
        
        let favoritesVC = FavouritesVC()
        NetworkManager.shared.fetchDishesResipes(cuisine: dishes) { recipes in
            favoritesVC.allRecipes = recipes.results
        }
        favoritesVC.title = "Dishes of \(dishes)"
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
}
