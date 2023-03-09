//
//  ThirdCollectionView.swift
//  CustomCollectionCell
//
//  Created by Alexey Davidenko on 07.03.2023.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {
    
fileprivate let grayImage: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "grayImage2")
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 16
    return iv
}()

fileprivate let image: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "roundLogo")
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.layer.cornerRadius = iv.frame.height / 2
    return iv
}()
    
private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Chicken and Vegetable wrap"
    label.numberOfLines = 2
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}()

override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(grayImage)
    contentView.addSubview(image)
    contentView.addSubview(titleLabel)
    
    grayImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70).isActive = true
    grayImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    grayImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
    grayImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    
    image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
    image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
    image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
   // titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 40).isActive = true
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

override func layoutSubviews() {
    super.layoutSubviews()

}
}
