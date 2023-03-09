//
//  CustomCell.swift
//  CookBook
//
//  Created by Alexey Davidenko on 05.03.2023.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    var recipe: Result!
    
    let images = ["heart", "tappedHeart"]
    var currentImageIndex = 0
    
    fileprivate let image: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.image = UIImage(named: "logo3")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of the recipe"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let heart: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "heart")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        return button
    }()
    
    private func buttonGrowingEffect(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = CGAffineTransform.identity
            })
        })
    }

    @objc func buttonTapped(_ sender: UIButton) {
        DataManager.shared.save(recipe: recipe)
        currentImageIndex = (currentImageIndex + 1) % images.count
        heartButton.setImage(UIImage(named: images[currentImageIndex]), for: .normal)
        buttonGrowingEffect(heartButton)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(heartButton)
        
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 12
    }
    func set(recipe: Result) {
        self.titleLabel.text = recipe.title
        self.recipe = recipe
        ImageManager.shared.fetchImage(from: recipe.image) { image in
            self.image.image = image
        }
    }
}
