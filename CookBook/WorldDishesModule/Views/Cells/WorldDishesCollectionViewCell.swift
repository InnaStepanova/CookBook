//
//  WorldDishesCollectionViewCell.swift
//  CookBook
//
//  Created by Эдгар Исаев on 28.02.2023.
//

import UIKit

class WorldDishesCollectionViewCell: UICollectionViewCell {
    
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            backgroundImageView.image = data.image
            mainLabel.text = data.name
        }
    }
    
    static let idDishesCell = "idDishesCell"
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        addSubview(backgroundImageView)
        setupGradient()
        addSubview(mainLabel)
    }
    
    
    private func setupGradient() {
        let colorTop = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let colorBot = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colorTop, colorBot]
        gradientLayer.locations = [0.5, 1]
        gradientLayer.cornerRadius = 10
        self.layer.addSublayer(gradientLayer)
    }
    
}

extension WorldDishesCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mainLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
