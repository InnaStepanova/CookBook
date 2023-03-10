//
//  FourthCollectionView.swift
//  CustomCollectionCell
//
//  Created by Alexey Davidenko on 08.03.2023.
//

import UIKit

class FourthCollectionViewCell: UICollectionViewCell {

    lazy var image: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of the recipie"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func set(recipe: Result) {
        titleLabel.text = recipe.title
        ImageManager.shared.fetchImage(from: recipe.image) { image in
            self.image.image = image
        }
    }
}

