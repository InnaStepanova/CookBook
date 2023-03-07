//
//  recipeCall.swift
//  CookBook
//
//  Created by Даниил Петров on 01.03.2023.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    static let identifier = "RecipeCell"
    var isChecked = true
    
    lazy var favouriteButton: UIButton = {
       let button = UIButton()
       button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
       button.tintColor = .red
       button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
   }()
    
    @objc func favouriteButtonPressed() {
        
        if isChecked {
            favouriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            isChecked = false
        } else {
            favouriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            isChecked = true
        }
    }

    
    private let recipeName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let cellImageView: UIImageView = {
        
        let image = UIImage()
        let cellImageView = UIImageView(image: image)

        cellImageView.contentMode = .scaleToFill
        cellImageView.clipsToBounds = true
        cellImageView.layer.cornerRadius = 15
        cellImageView.translatesAutoresizingMaskIntoConstraints = false

        return cellImageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        
    }
    private func setupViews() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(recipeName)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            cellImageView.widthAnchor.constraint(equalToConstant: self.frame.width + 10),
            cellImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            recipeName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeName.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 8),
            recipeName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            favouriteButton.heightAnchor.constraint(equalToConstant: 30),
            favouriteButton.widthAnchor.constraint(equalToConstant: 30),
            favouriteButton.topAnchor.constraint(equalTo: cellImageView.topAnchor),
            favouriteButton.leadingAnchor.constraint(equalTo: cellImageView.leadingAnchor,constant: 5)
               ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withImage image: UIImage, text: String) {
        cellImageView.image = image
        recipeName.text = text
    }
    
    func set(recipe: Result) {
        recipeName.text = recipe.title
        ImageManager.shared.fetchImage(from: recipe.image) { image in
            self.cellImageView.image = image
        }
    }
}
