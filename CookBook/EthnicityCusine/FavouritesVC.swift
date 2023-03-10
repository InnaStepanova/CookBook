//
//  favouritesVC.swift
//  CookBook
//
//  Created by Даниил Петров on 01.03.2023.
//

import UIKit

class FavouritesVC: UIViewController, UITextFieldDelegate {
    
    var typeOfRequest: TypeOfRequest = .search
    var parametr = ""
    var allRecipes: [Result] = [] {
        didSet {
            favoriteView.recipesTableView.reloadData()
        }
    }
    
    let searchTextField: UITextField = {
        let field = UITextField()
        field.textAlignment = .left
        field.borderStyle = .none
        field.layer.borderWidth = 1
        field.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        field.layer.cornerRadius = 8
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 10,
                                              height: 0))
        field.leftViewMode = .always
        field.clearButtonMode = .always
        field.placeholder = "What do you want to find?"
        field.returnKeyType = .search
        return field
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .red
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let favoriteView = FavouritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
        
        
//        title = "Search of recipes"
        print(view.frame.width)
        view.backgroundColor = .white
        tabBarItem.title = "Search"
        favoriteView.recipesTableView.dataSource = self
        favoriteView.recipesTableView.delegate = self
        favoriteView.recipesTableView.prefetchDataSource = self
        setupView()
        
        searchTextField.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    
    private func setupView() {
        view.addSubview(favoriteView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
                NSLayoutConstraint.activate([
                    favoriteView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
                    favoriteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    favoriteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    favoriteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    
                    searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                    searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                    searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
                    searchTextField.heightAnchor.constraint(equalToConstant: 40),
                    
                    searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                    searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                    searchButton.heightAnchor.constraint(equalTo: searchTextField.heightAnchor)
                ])
    }
    
    @objc private func searchButtonPressed() {
        if let text = searchTextField.text {
            title = "Result of search: \(text)"
            parametr = text
            NetworkManager.shared.fetchRecipes(parametr: text, typeOfRequest: .search, offset: 0) { recipes in
                self.allRecipes = recipes.results
            }
        }
        tabBarItem.title = "Search"
        searchTextField.text = ""
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            title = "Result of search: \(text)"
            parametr = text
            typeOfRequest = .search
            NetworkManager.shared.fetchRecipes(parametr: text, typeOfRequest: .search, offset: 0) { recipes in
                self.allRecipes = recipes.results
            }
        }
        tabBarItem.title = "Search"
        searchTextField.text = ""
        searchTextField.endEditing(true)
        return true
    }
    
    // MARK: AddGesture(TapScreen)
        
        private func addGesture() {
            let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapScreen)
            let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
            swipeScreen.cancelsTouchesInView = false
            view.addGestureRecognizer(swipeScreen)
        }
        @objc private func hideKeyboard() {
            view.endEditing(true)
        }
}

extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecipes.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    RecipeCell.identifier,
                                                 for: indexPath) as! RecipeCell
    
        cell.isChecked = false
        cell.favouriteButton.setImage(UIImage(named: "heart"), for: .normal)
        let recipe = allRecipes[indexPath.item]
        cell.set(recipe: recipe, index: indexPath.item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipe = allRecipes[indexPath.item]
        let recipeVC = RecipeScreenViewController()
        NetworkManager.shared.fetchRecipe(id: recipe.id) { recipe in
            recipeVC.setupUI(with: recipe)
        }
        navigationController?.pushViewController(recipeVC, animated: true)
    }
}

extension FavouritesVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            print(index.row)
            if index.row >= allRecipes.count - 3 {
                print("New request")
                NetworkManager.shared.fetchRecipes(parametr: parametr, typeOfRequest: typeOfRequest, offset: allRecipes.count) { recipes in
                    self.allRecipes += recipes.results
                    tableView.reloadData()
                }
            }
        }
    }
}
