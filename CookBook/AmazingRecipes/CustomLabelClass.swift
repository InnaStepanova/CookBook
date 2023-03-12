//
//  customLabel.swift
//  CookBook
//
//  Created by Alexey Davidenko on 12.03.2023.
//

import UIKit

class customLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    func setupLabel() {
        font = .systemFont(ofSize: 20, weight: .bold)
        textColor = .black
        numberOfLines = 1
        textAlignment = .left
        setText("Custom text")
    }
    
    func setText(_ text: String) {
        self.text = text
    }

}
