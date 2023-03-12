//
//  SeeAllButton.swift
//  CookBook
//
//  Created by Alexey Davidenko on 11.03.2023.
//

import UIKit

class SeeAllButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupButton()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        setTitleColor(.systemRed, for: .normal)
        setTitle("See all", for: .normal)
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
}
