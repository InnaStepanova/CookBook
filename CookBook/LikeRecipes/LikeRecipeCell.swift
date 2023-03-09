//
//  LikeRecipeCell.swift
//  CookBook
//
//  Created by Лаванда on 09.03.2023.
//

import UIKit

class LikeRecipeCell: UITableViewCell {
    
    var recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    var recipeTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(recipeImage)
        addSubview(recipeTitle)
    }
    
    private func setConstraints() {
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            recipeImage.heightAnchor.constraint(equalToConstant: 120),
            recipeImage.widthAnchor.constraint(equalToConstant: 120),
            
            recipeTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            recipeTitle.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: 20),
            recipeTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    func set(recipe: Result) {
        recipeTitle.text = recipe.title
        ImageManager.shared.fetchImage(from: recipe.image) { image in
            self.recipeImage.image = image
        }
    }
}
