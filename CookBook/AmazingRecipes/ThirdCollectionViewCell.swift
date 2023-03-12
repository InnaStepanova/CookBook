//
//  ThirdCollectionView.swift
//  CustomCollectionCell
//
//  Created by Alexey Davidenko on 07.03.2023.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {
    
    private let grayView: UIView = {
    let iv = UIView()
    iv.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.layer.cornerRadius = 16
    return iv
}()

    private let image: UIImageView = {
    let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = iv.frame.height / 2
    return iv
}()
    
    private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 3
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}()

override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(grayView)
    contentView.addSubview(image)
    contentView.addSubview(titleLabel)
    
    
    grayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70).isActive = true
    grayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    grayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
    grayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    
    image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    image.heightAnchor.constraint(equalTo: grayView.heightAnchor).isActive = true
    image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
    image.centerYAnchor.constraint(equalTo: grayView.topAnchor).isActive = true
    image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
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
            self.image.layer.cornerRadius = self.image.frame.height / 2
        }
    }
}
