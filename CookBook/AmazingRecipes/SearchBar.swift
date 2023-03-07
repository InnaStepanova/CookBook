//
//  SearchBar.swift
//  CookBook
//
//  Created by Alexey Davidenko on 05.03.2023.
//

import UIKit

class CustomSearchBar: UISearchBar, UISearchBarDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        searchBarStyle = .minimal
        placeholder = "Search recipes"
        barTintColor = .white

        let searchIcon = UIImage(systemName: "fork.knife")?.withRenderingMode(.alwaysTemplate)
        let searchImageView = UIImageView(image: searchIcon)
        searchImageView.tintColor = .gray
        searchImageView.contentMode = .scaleAspectFit
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView.addSubview(searchImageView)
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchImageView.centerXAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 20),
            searchImageView.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 16),
            searchImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        self.searchTextField.leftView = leftView
        self.searchTextField.leftViewMode = .always
        self.searchTextField.clearButtonMode = .never
    }
}

