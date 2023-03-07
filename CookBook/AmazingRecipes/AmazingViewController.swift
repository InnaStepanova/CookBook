//
//  AmazingViewController.swift
//  CookBook
//
//  Created by Alexey Davidenko on 05.03.2023.
//

import UIKit

class AmazingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    
    var hotRecipes: [Result]?

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let searchBar = CustomSearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
    let trendingLabel = UILabel()
    let seeAllButton = UIButton(type: .system)
    let fullString = NSMutableAttributedString(string: "Trending now ")
    let image1Attachment = NSTextAttachment()
    let stack = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchAllRecipesOfHot { hotRecipes in
            self.hotRecipes = hotRecipes.results
            self.collectionView.reloadData()
        }
        view.backgroundColor = .white
        title = "Get amazing recipes for cook"
        tabBarItem.title = "Main"
        
        
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.75)
        collectionView.collectionViewLayout = layout
        
        view.addSubview(stack)
        stack.addArrangedSubview(trendingLabel)
        stack.addArrangedSubview(seeAllButton)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
//        view.addSubview(trendingLabel)
//        view.addSubview(seeAllButton)

        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            stack.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
//            trendingLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
//            trendingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            seeAllButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10),
//            seeAllButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let navController = self.tabBarController?.viewControllers![1] as! UINavigationController
        let vc = navController.topViewController as! FavouritesVC
        vc.allRecipes = hotRecipes
        vc.title = "Trending now 🔥"
        vc.tabBarItem.title = "Search"
        self.tabBarController?.selectedIndex = 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotRecipes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! MyCollectionViewCell
        
        if let recipe = hotRecipes?[indexPath.item] {
            cell.set(recipe: recipe)
        }
       
//        cell.backgroundColor = .systemBackground
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

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}
