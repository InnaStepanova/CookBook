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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [amountLabel, ingredientLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    //MARK: - Setup UI
    func configure(with ingredient: String, amount: String) {
        ingredientLabel.text = ingredient
        amountLabel.text = amount
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
    
    private func setupConstraints() {
        addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
