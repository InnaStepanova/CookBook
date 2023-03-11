//
//  FirstCollectionView.swift
//  CustomCollectionCell
//
//  Created by Alexey Davidenko on 04.03.2023.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    var recipe: Result!
    var isFavorite: Bool = false
    
    let images = ["heart", "tappedHeart"]
    var currentImageIndex = 0
    
    fileprivate let image: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo3")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of the recipie test test test"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private lazy var personLabel: UILabel = {
//        let label = UILabel()
//        label.text = "userLabel"
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.textColor = .gray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    fileprivate let heart: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "heart")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        return button
    }()
    
    func buttonGrowingEffect(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = CGAffineTransform.identity
            })
        })
    }

    @objc func buttonTapped(_ sender: UIButton) {
        isFavorite.toggle()
        if isFavorite {
            heartButton.setImage(UIImage(named: "tappedHeart"), for: .normal)
            DataManager.shared.save(recipe: recipe)
        } else {
            heartButton.setImage(UIImage(named: "heart"), for: .normal)
            DataManager.shared.delete(recipe: recipe)
        }
        buttonGrowingEffect(sender)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
//        contentView.addSubview(personLabel)
        contentView.addSubview(heartButton)
        
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
       // image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: personLabel.topAnchor).isActive = true
        
//        personLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
//        personLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        personLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        personLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        
        heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        heartButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        heartButton.setImage(UIImage(named: "heart"), for: .normal)
    }
    
    func set(recipe: Result) {
        self.titleLabel.text = recipe.title
        self.recipe = recipe
        ImageManager.shared.fetchImage(from: recipe.image) { image in
            self.image.image = image
        }
        if DataManager.shared.isRecipeInFavorite(recipe) {
            isFavorite = true
            heartButton.setImage(UIImage(named: "tappedHeart"), for: .normal)
        }
    }
}
