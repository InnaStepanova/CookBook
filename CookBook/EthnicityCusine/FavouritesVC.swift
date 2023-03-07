//
//  favouritesVC.swift
//  CookBook
//
//  Created by Даниил Петров on 01.03.2023.
//

import UIKit

class FavouritesVC: UIViewController, UISearchResultsUpdating {
    
    var allRecipes: [Result]? {
        didSet {
            favoriteView.recipesTableView.reloadData()
        }
    }
    
    private let favoriteView = FavouritesView()
    
    let searchController: UISearchController = {
        let results = UIViewController()

        let vc = UISearchController(searchResultsController: results)
         vc.searchBar.placeholder = "What do you want to find?"
         vc.searchBar.searchBarStyle  = .minimal
         vc.definesPresentationContext = true
         vc.searchBar.endEditing(true)
         
         return vc
     }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame.width)
        view.backgroundColor = .white
        tabBarItem.title = "Search"
        favoriteView.recipesTableView.dataSource = self
        favoriteView.recipesTableView.delegate = self
        setupView()

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
              
        searchController.searchResultsUpdater = self
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
                NSLayoutConstraint.activate([
                    favoriteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                    favoriteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    favoriteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    favoriteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                ])

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        print(query)
    }
}

extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! CustomHeader
        view.title.text = "Favourites"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecipes?.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    RecipeCell.identifier,
                                                 for: indexPath) as! RecipeCell
        cell.isChecked = false
        cell.favouriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        if let recipe = allRecipes?[indexPath.item] {
            cell.set(recipe: recipe)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let recipe = allRecipes?[indexPath.item] else {return}
        let recipeVC = RecipeScreenViewController()
        NetworkManager.shared.fetchRecipe(id: recipe.id) { recipe in
            recipeVC.recipe = recipe
        }
        navigationController?.pushViewController(recipeVC, animated: true)
    }
}
