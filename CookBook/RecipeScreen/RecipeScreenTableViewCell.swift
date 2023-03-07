//
//  RecipeScreenTableViewCell.swift
//  CookBook
//
//  Created by Жадаев Алексей on 28.02.2023.
//

import UIKit

class RecipeScreenTableViewCell: UITableViewCell {
    //MARK: - Properties
    private let ingredientLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Setup UI
    func configure(with ingredient: String) {
        ingredientLabel.text = "* \(ingredient)"
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
    
    private func setupConstraints() {
        addSubview(ingredientLabel)
        NSLayoutConstraint.activate([
            ingredientLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ingredientLabel.topAnchor.constraint(equalTo: topAnchor),
            ingredientLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            ingredientLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
