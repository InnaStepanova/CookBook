//
//  SecondCollectionView.swift
//  CustomCollectionCell
//
//  Created by Alexey Davidenko on 08.03.2023.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    var selectedButton = 0
    
    public let meals = ["main course",
                        "side dish",
                        "dessert",
                        "appetizer",
                        "salad",
                        "bread",
                        "breakfast",
                        "soup",
                        "beverage",
                        "sauce",
                        "marinade",
                        "fingerfood",
                        "snack",
                        "drink"]
    
    let mealTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("breakfast", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped(_ sender: UIButton) {
        mealTypeButton.isSelected = !mealTypeButton.isSelected
        if mealTypeButton.isSelected {
            mealTypeButton.tintColor = .systemRed
            mealTypeButton.setTitleColor(.systemBackground, for: .selected)
        } else {
            mealTypeButton.tintColor = .systemBackground
            mealTypeButton.setTitleColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), for: .normal)
        }
        print("Button was selected")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(mealTypeButton)
        
        mealTypeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        mealTypeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        mealTypeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        mealTypeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
