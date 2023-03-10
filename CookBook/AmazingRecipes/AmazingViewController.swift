//
//  AmazingViewController.swift
//  CookBook
//
//  Created by Alexey Davidenko on 05.03.2023.
//

import UIKit

class AmazingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    var hotRecipes: [Result]?
    var typeRecipes: [Result] = [] {
        didSet{
            thirdCollectionView.reloadData()
            fourthCollectionView.reloadData()
        }
    }
    var vegetarianRecipes: [Result] = [] {
        didSet{
            fourthCollectionView.reloadData()
        }
    }
    
    let meals = ["Main course",
                        "Side dish",
                        "Dessert",
                        "Appetizer",
                        "Salad",
                        "Bread",
                        "Breakfast",
                        "Soup",
                        "Beverage",
                        "Sauce",
                        "Marinade",
                        "Fingerfood",
                        "Snack",
                        "Drink"]
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 500)
    }
    
    let firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let thirdCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let fourthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let trendingLabel = UILabel()
    let recentLabel = UILabel()
    let popularCategoryLabel = UILabel()
    
    let seeAllButton = UIButton(type: .system)
    let secondSeeAllButton = UIButton(type: .system)
    
    let fullString = NSMutableAttributedString(string: "Trending now ")
    let image1Attachment = NSTextAttachment()
    
    let firstStack = UIStackView()
    let secondStack = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchAllRecipesOfHot { hotRecipes in
            self.hotRecipes = hotRecipes.results
            self.firstCollectionView.reloadData()
        }
        NetworkManager.shared.fetchAllRecipesOfType(type: "Dessert") { recipes in
            self.typeRecipes = recipes.results
        }
        NetworkManager.shared.fetchVegetarianRecipes { recipes in
            self.vegetarianRecipes = recipes.results
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstStack)
        firstStack.addArrangedSubview(trendingLabel)
        firstStack.addArrangedSubview(seeAllButton)
        contentView.addSubview(secondStack)
        secondStack.addArrangedSubview(recentLabel)
        secondStack.addArrangedSubview(secondSeeAllButton)
        contentView.addSubview(popularCategoryLabel)
        contentView.addSubview(firstCollectionView)
        contentView.addSubview(secondCollectionView)
        contentView.addSubview(thirdCollectionView)
        contentView.addSubview(fourthCollectionView)
        
        view.backgroundColor = .white
        title = "Get amazing recipes for cook"
        tabBarItem.title = "Main"
    
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchTextField.delegate = self

        firstStack.axis = .horizontal
        firstStack.translatesAutoresizingMaskIntoConstraints = false
        
        secondStack.axis = .horizontal
        secondStack.translatesAutoresizingMaskIntoConstraints = false
        
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        firstCollectionView.showsHorizontalScrollIndicator = false
        firstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        firstCollectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: "FirstCustomCell")
        
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.showsHorizontalScrollIndicator = false
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        secondCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: "SecondCustomCell")
        
        thirdCollectionView.dataSource = self
        thirdCollectionView.delegate = self
        thirdCollectionView.showsHorizontalScrollIndicator = false
        thirdCollectionView.translatesAutoresizingMaskIntoConstraints = false
        thirdCollectionView.register(ThirdCollectionViewCell.self, forCellWithReuseIdentifier: "ThirdCustomCell")

        fourthCollectionView.dataSource = self
        fourthCollectionView.delegate = self
        fourthCollectionView.showsHorizontalScrollIndicator = false
        fourthCollectionView.translatesAutoresizingMaskIntoConstraints = false
        fourthCollectionView.register(FourthCollectionViewCell.self, forCellWithReuseIdentifier: "FourthCustomCell")
        
        trendingLabel.text = "Trending now"
        trendingLabel.font = .systemFont(ofSize: 20, weight: .bold)
        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        popularCategoryLabel.text = "Popular category"
        popularCategoryLabel.font = .systemFont(ofSize: 20, weight: .bold)
        popularCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        recentLabel.text = "Vegetarian recipes"
        recentLabel.font = .systemFont(ofSize: 20, weight: .bold)
        recentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        image1Attachment.image = UIImage(named: "flameImage")
        image1Attachment.bounds = CGRect(x: 0, y: -3, width: 25, height: 25)
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        trendingLabel.attributedText = fullString
        
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.setTitleColor(.systemRed, for: .normal)
        seeAllButton.contentMode = .scaleAspectFill
        seeAllButton.clipsToBounds = true
        seeAllButton.addTarget(self, action: #selector(firstButtonTapped(_ :)), for: .touchUpInside)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        secondSeeAllButton.setTitle("See all", for: .normal)
        secondSeeAllButton.setTitleColor(.systemRed, for: .normal)
        secondSeeAllButton.contentMode = .scaleAspectFill
        secondSeeAllButton.clipsToBounds = true
        secondSeeAllButton.addTarget(self, action: #selector(secondButtonTapped(_ :)), for: .touchUpInside)
        secondSeeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        firstCollectionView.collectionViewLayout = layout

        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        secondCollectionView.collectionViewLayout = layout2

        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .horizontal
        thirdCollectionView.collectionViewLayout = layout3

        let layout4 = UICollectionViewFlowLayout()
        layout4.scrollDirection = .horizontal
        fourthCollectionView.collectionViewLayout = layout4
    
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchButton.heightAnchor.constraint(equalTo: searchTextField.heightAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            firstStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            firstStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            firstStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            firstCollectionView.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 15),
            firstCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            firstCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            firstCollectionView.heightAnchor.constraint(equalTo: firstCollectionView.widthAnchor, multiplier: 0.85),
            
            popularCategoryLabel.topAnchor.constraint(equalTo: firstCollectionView.bottomAnchor, constant: 5),
            popularCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            secondCollectionView.topAnchor.constraint(equalTo: popularCategoryLabel.bottomAnchor, constant: 15),
            secondCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            secondCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            secondCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            thirdCollectionView.topAnchor.constraint(equalTo: secondCollectionView.bottomAnchor, constant: 15),
            thirdCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            thirdCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thirdCollectionView.heightAnchor.constraint(equalTo: thirdCollectionView.widthAnchor, multiplier: 0.55),

            secondStack.topAnchor.constraint(equalTo: thirdCollectionView.bottomAnchor, constant: 5),
            secondStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            secondStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            secondSeeAllButton.trailingAnchor.constraint(equalTo: seeAllButton.trailingAnchor),

            fourthCollectionView.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 5),
            fourthCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            fourthCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fourthCollectionView.heightAnchor.constraint(equalTo: fourthCollectionView.widthAnchor, multiplier: 0.6),
            fourthCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15)
        ])
    }
    //func added for "see all" button
    @objc func firstButtonTapped(_ sender: UIButton) {
        let vc = FavouritesVC()
        vc.allRecipes = hotRecipes
        vc.title = "Trending now 🔥"
        vc.tabBarItem.title = "Search"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func secondButtonTapped(_ sender: UIButton) {
        let vc = FavouritesVC()
        vc.allRecipes = vegetarianRecipes
        vc.title = "Vegetarian recipes"
        vc.tabBarItem.title = "Search"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            navigationItem.hidesSearchBarWhenScrolling = true
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
        var returnValue = 0
        
        if collectionView == firstCollectionView {
            returnValue = hotRecipes?.count ?? 0
        }
        
        if collectionView == secondCollectionView {
            returnValue = meals.count
        }

        if collectionView == thirdCollectionView {
            returnValue = typeRecipes.count
        }

        if collectionView == fourthCollectionView {
            returnValue = vegetarianRecipes.count
        }
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == firstCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCustomCell", for: indexPath) as! FirstCollectionViewCell
            if let recipe = hotRecipes?[indexPath.item] {
                cell.set(recipe: recipe)
            }
            return cell
            
        } else if collectionView == secondCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCustomCell", for: indexPath) as! SecondCollectionViewCell
            let meal = meals[indexPath.item]
            cell.set(buttonTitle: meal, index: indexPath.item)
            return cell
            
        } else if collectionView == thirdCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCustomCell", for: indexPath) as! ThirdCollectionViewCell
            let recipe = typeRecipes[indexPath.item]
            cell.set(recipe: recipe)
            return cell
            
        } else if collectionView == fourthCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCustomCell", for: indexPath) as! FourthCollectionViewCell
            
            let recipe = vegetarianRecipes[indexPath.item]
            cell.set(recipe: recipe)
            return cell
            
        } else {
            preconditionFailure("Unknown collection view!")
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == firstCollectionView {
            guard let recipe = hotRecipes?[indexPath.item] else {return}
            let recipeVC = RecipeScreenViewController()
            NetworkManager.shared.fetchRecipe(id: recipe.id) { recipe in
                recipeVC.setupUI(with: recipe)
            }
            navigationController?.pushViewController(recipeVC, animated: true)
        }
        
        if collectionView == secondCollectionView {
            let type = meals[indexPath.item]
            NetworkManager.shared.fetchAllRecipesOfType(type: type) { recipes in
                self.typeRecipes = recipes.results
            }
        }
        
        if collectionView == thirdCollectionView {
            let recipe = typeRecipes[indexPath.item]
            let recipeVC = RecipeScreenViewController()
            NetworkManager.shared.fetchRecipe(id: recipe.id) { recipe in
                recipeVC.setupUI(with: recipe)
            }
            navigationController?.pushViewController(recipeVC, animated: true)
        }
        
        if collectionView == fourthCollectionView {
            let recipe = typeRecipes[indexPath.item]
            let recipeVC = RecipeScreenViewController()
            NetworkManager.shared.fetchRecipe(id: recipe.id) { recipe in
                recipeVC.setupUI(with: recipe)
            }
            navigationController?.pushViewController(recipeVC, animated: true)
        }
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

extension AmazingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == secondCollectionView {
            let categoreFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
            let categoryAttributes = [NSAttributedString.Key.font : categoreFont]
            let categoryWidth = meals[indexPath.item].size(withAttributes: categoryAttributes).width + 15
            return CGSize(width: categoryWidth, height: collectionView.frame.height)
        }
        if collectionView == firstCollectionView {
            return CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.83)
        }
        
        if collectionView == thirdCollectionView {
            return CGSize(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.50)
        }
        
        if collectionView == fourthCollectionView {
            return CGSize(width: UIScreen.main.bounds.width * 0.33, height: UIScreen.main.bounds.width * 0.55)
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

