//
//  AmazingViewController.swift
//  CookBook
//
//  Created by Alexey Davidenko on 05.03.2023.
//

import UIKit

class AmazingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    var hotRecipes: [Result]?
    
    let searchTextField: UITextField = {
        let field = UITextField()
        field.textAlignment = .left
        field.borderStyle = .roundedRect
        field.placeholder = "What do you want to find?"
        field.returnKeyType = .search
        return field
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .red
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let trendingLabel = UILabel()
    let seeAllButton = UIButton(type: .system)
    let fullString = NSMutableAttributedString(string: "Trending now ")
    let image1Attachment = NSTextAttachment()
    let stack = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let proverka = DataManager.shared.fetchRecipes()
        print("Proverka \(proverka)")
        NetworkManager.shared.fetchAllRecipesOfHot { hotRecipes in
            self.hotRecipes = hotRecipes.results
            self.collectionView.reloadData()
        }
        view.backgroundColor = .white
        title = "Get amazing recipes for cook"
        tabBarItem.title = "Main"
    
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchTextField.delegate = self
        
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        trendingLabel.text = "Trending now"
        trendingLabel.font = .systemFont(ofSize: 20, weight: .bold)
        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        image1Attachment.image = UIImage(named: "flameImage")
        image1Attachment.bounds = CGRect(x: 0, y: -3, width: 25, height: 25)
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        trendingLabel.attributedText = fullString
        
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.setTitleColor(.systemRed, for: .normal)
        seeAllButton.contentMode = .scaleAspectFill
        seeAllButton.clipsToBounds = true
        seeAllButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.85)
        collectionView.collectionViewLayout = layout
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(stack)
        stack.addArrangedSubview(trendingLabel)
        stack.addArrangedSubview(seeAllButton)
        view.addSubview(collectionView)
        
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            collectionView.topAnchor.constraint(equalTo: stack.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1),
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchButton.heightAnchor.constraint(equalTo: searchTextField.heightAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let vc = FavouritesVC()
        vc.allRecipes = hotRecipes
        vc.title = "Trending now 🔥"
        vc.tabBarItem.title = "Search"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func searchButtonPressed() {
        if let text = searchTextField.text {
            
            let navController = self.tabBarController?.viewControllers![1] as! UINavigationController
            let vc = navController.topViewController as! FavouritesVC
            NetworkManager.shared.fetcResipesOf(search: text) { recipes in
                vc.allRecipes = recipes.results
            }
            vc.title = "Result of search: \(text)"
            vc.tabBarItem.title = "Search"
            self.tabBarController?.selectedIndex = 1
        }
        searchTextField.text = ""
        searchTextField.endEditing(true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotRecipes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! MyCollectionViewCell
        
        if let recipe = hotRecipes?[indexPath.item] {
            cell.set(recipe: recipe)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let recipe = hotRecipes?[indexPath.item] else {return}
        let recipeVC = RecipeScreenViewController()
        NetworkManager.shared.fetchRecipe(id: recipe.id) { recipe in
            recipeVC.setupUI(with: recipe)
        }
        navigationController?.pushViewController(recipeVC, animated: true)

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = searchTextField.text {
            
            let navController = self.tabBarController?.viewControllers![1] as! UINavigationController
            let vc = navController.topViewController as! FavouritesVC
            NetworkManager.shared.fetcResipesOf(search: text) { recipes in
                vc.allRecipes = recipes.results
            }
            vc.title = "Result of search: \(text)"
            vc.tabBarItem.title = "Search"
            self.tabBarController?.selectedIndex = 1
        }
        searchTextField.text = ""
        searchTextField.endEditing(true)
        return true
    }
}
