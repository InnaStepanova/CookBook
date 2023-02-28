//
//  WorldDishesCollectionViewCell.swift
//  CookBook
//
//  Created by Эдгар Исаев on 28.02.2023.
//

import UIKit

class WorldDishesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Public methods
    
    func configureCell(with image: UIImage, countryName: String) {
        backgroundImageView.image = image
        mainLabel.text = countryName
        configureConstraints()
    }
    
    // MARK: - Private methods
    
    private func configureConstraints() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(mainLabel)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
            mainLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10),
            mainLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor)
        ])
    }
}
