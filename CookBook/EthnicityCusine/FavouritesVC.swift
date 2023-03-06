//
//  favouritesVC.swift
//  CookBook
//
//  Created by Даниил Петров on 01.03.2023.
//

import UIKit

class FavouritesVC: UIViewController {
    
    var allRecipes: [Result]?
    
    private let favoriteView = FavouritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame.width)
        view.backgroundColor = .white
        tabBarItem.title = "Search"
        favoriteView.recipesTableView.dataSource = self
        favoriteView.recipesTableView.delegate = self
        setupView()
        
    }
    
    
    private func setupView() {
        view.addSubview(favoriteView)
        NSLayoutConstraint.activate([
            favoriteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoriteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            favoriteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
        
//        tableView.rowHeight = UITableView.automaticDimension
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

