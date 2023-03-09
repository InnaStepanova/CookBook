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

//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let thirdCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let fourthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
//    let trendingLabel = UILabel()
//    let seeAllButton = UIButton(type: .system)
//    let fullString = NSMutableAttributedString(string: "Trending now ")
//    let image1Attachment = NSTextAttachment()
//    let stack = UIStackView()
    
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
        
//        stack.axis = .horizontal
//        stack.translatesAutoresizingMaskIntoConstraints = false
        firstStack.axis = .horizontal
        firstStack.translatesAutoresizingMaskIntoConstraints = false
        
        secondStack.axis = .horizontal
        secondStack.translatesAutoresizingMaskIntoConstraints = false

//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        firstCollectionView.showsHorizontalScrollIndicator = false
        firstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //firstCollectionView.backgroundColor = .yellow
        firstCollectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: "FirstCustomCell")
        
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.showsHorizontalScrollIndicator = false
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //secondCollectionView.backgroundColor = .green
        secondCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: "SecondCustomCell")
        
        thirdCollectionView.dataSource = self
        thirdCollectionView.delegate = self
        thirdCollectionView.showsHorizontalScrollIndicator = false
        thirdCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //thirdCollectionView.backgroundColor = .blue
        thirdCollectionView.register(ThirdCollectionViewCell.self, forCellWithReuseIdentifier: "ThirdCustomCell")

        fourthCollectionView.dataSource = self
        fourthCollectionView.delegate = self
        fourthCollectionView.showsHorizontalScrollIndicator = false
        fourthCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //fourthCollectionView.backgroundColor = .red
        fourthCollectionView.register(FourthCollectionViewCell.self, forCellWithReuseIdentifier: "FourthCustomCell")
        
//        trendingLabel.text = "Trending now"
//        trendingLabel.font = .systemFont(ofSize: 20, weight: .bold)
//        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        image1Attachment.image = UIImage(named: "flameImage")
//        image1Attachment.bounds = CGRect(x: 0, y: -3, width: 25, height: 25)
//        let image1String = NSAttributedString(attachment: image1Attachment)
//        fullString.append(image1String)
//        trendingLabel.attributedText = fullString
        
        trendingLabel.text = "Trending now"
        trendingLabel.font = .systemFont(ofSize: 20, weight: .bold)
        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        popularCategoryLabel.text = "Popular category"
        popularCategoryLabel.font = .systemFont(ofSize: 20, weight: .bold)
        popularCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        recentLabel.text = "Recent recipe"
        recentLabel.font = .systemFont(ofSize: 20, weight: .bold)
        recentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        image1Attachment.image = UIImage(named: "flameImage")
        image1Attachment.bounds = CGRect(x: 0, y: -3, width: 25, height: 25)
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        trendingLabel.attributedText = fullString
        
//        seeAllButton.setTitle("See all", for: .normal)
//        seeAllButton.setTitleColor(.systemRed, for: .normal)
//        seeAllButton.contentMode = .scaleAspectFill
//        seeAllButton.clipsToBounds = true
//        seeAllButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
//        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
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

//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.85)
//        collectionView.collectionViewLayout = layout
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.83)
        firstCollectionView.collectionViewLayout = layout

        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        layout2.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.20, height: UIScreen.main.bounds.width * 0.60)
        secondCollectionView.collectionViewLayout = layout2

        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .horizontal
        layout3.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.50)
        thirdCollectionView.collectionViewLayout = layout3

        let layout4 = UICollectionViewFlowLayout()
        layout4.scrollDirection = .horizontal
        layout4.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.33, height: UIScreen.main.bounds.width * 0.55)
        fourthCollectionView.collectionViewLayout = layout4
        
//        view.addSubview(searchTextField)
//        view.addSubview(searchButton)
//        view.addSubview(stack)
//        stack.addArrangedSubview(trendingLabel)
//        stack.addArrangedSubview(seeAllButton)
//        view.addSubview(collectionView)
        
        view.addSubview(firstStack)
        firstStack.addArrangedSubview(trendingLabel)
        firstStack.addArrangedSubview(seeAllButton)
        view.addSubview(secondStack)
        secondStack.addArrangedSubview(recentLabel)
        secondStack.addArrangedSubview(secondSeeAllButton)
        view.addSubview(popularCategoryLabel)
        view.addSubview(firstCollectionView)
        view.addSubview(secondCollectionView)
        view.addSubview(thirdCollectionView)
        view.addSubview(fourthCollectionView)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
//            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
//
//            collectionView.topAnchor.constraint(equalTo: stack.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1),
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchButton.heightAnchor.constraint(equalTo: searchTextField.heightAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            firstStack.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 5),
            firstStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            firstStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            firstCollectionView.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 15),
            firstCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            firstCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //firstCollectionView.heightAnchor.constraint(equalTo: firstCollectionView.widthAnchor, multiplier: 0.85),
            firstCollectionView.heightAnchor.constraint(equalTo: firstCollectionView.widthAnchor, multiplier: 0.1),
            
            popularCategoryLabel.topAnchor.constraint(equalTo: firstCollectionView.bottomAnchor, constant: 5),
            popularCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            secondCollectionView.topAnchor.constraint(equalTo: popularCategoryLabel.bottomAnchor, constant: 15),
            secondCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            secondCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            thirdCollectionView.topAnchor.constraint(equalTo: secondCollectionView.bottomAnchor, constant: 15),
            thirdCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            thirdCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thirdCollectionView.heightAnchor.constraint(equalTo: thirdCollectionView.widthAnchor, multiplier: 0.55),

            secondStack.topAnchor.constraint(equalTo: thirdCollectionView.bottomAnchor, constant: 5),
            secondStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            secondStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            fourthCollectionView.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 5),
            fourthCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            fourthCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fourthCollectionView.heightAnchor.constraint(equalTo: fourthCollectionView.widthAnchor, multiplier: 0.6)
        ])
    }
    //func added for "see all" button
    @objc func firstButtonTapped(_ sender: UIButton) {
        print("First See All button clicked")
    }
    
    @objc func secondButtonTapped(_ sender: UIButton) {
        print("Second See All button clicked")
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

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return hotRecipes?.count ?? 0
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnValue = 0
        
        if collectionView == firstCollectionView {
            returnValue = 5
        }
        
        if collectionView == secondCollectionView {
            returnValue = 15
        }

        if collectionView == thirdCollectionView {
            returnValue = 5
        }

        if collectionView == fourthCollectionView {
            returnValue = 5
        }
        return returnValue
    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! MyCollectionViewCell
//
//        if let recipe = hotRecipes?[indexPath.item] {
//            cell.set(recipe: recipe)
//        }
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == firstCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCustomCell", for: indexPath) as! FirstCollectionViewCell
            return cell
        } else if collectionView == secondCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCustomCell", for: indexPath) as! SecondCollectionViewCell
            return cell
        } else if collectionView == thirdCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCustomCell", for: indexPath) as! ThirdCollectionViewCell
            return cell
        } else if collectionView == fourthCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCustomCell", for: indexPath) as! FourthCollectionViewCell
            return cell
        } else {
            preconditionFailure("Unknown collection view!")
        }
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
