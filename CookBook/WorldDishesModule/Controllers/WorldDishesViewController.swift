//
//  WorldDishesViewController.swift
//  CookBook
//
//  Created by Эдгар Исаев on 28.02.2023.
//

import UIKit

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

