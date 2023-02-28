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

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(worldDishesLabel)
    }
}


extension WorldDishesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            worldDishesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            worldDishesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
}
