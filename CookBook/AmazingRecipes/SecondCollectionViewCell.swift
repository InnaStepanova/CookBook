//
//  SecondCollectionView.swift
//  CustomCollectionCell
//
//  Created by Alexey Davidenko on 08.03.2023.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {

    let typeMeal: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.pink
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? Resources.Colors.red : .white
            typeMeal.textColor = self.isSelected ? .white : Resources.Colors.pink
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(typeMeal)
        layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            typeMeal.centerYAnchor.constraint(equalTo: centerYAnchor),
            typeMeal.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func set(buttonTitle: String, index: Int) {
        typeMeal.text = buttonTitle
    }
}
