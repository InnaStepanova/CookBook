//
//  LikeRecipesVC.swift
//  CookBook
//
//  Created by Лаванда on 09.03.2023.
//

import UIKit

class LikeRecipesViewController: UIViewController {
    
    var tableView = UITableView()
    var recipes: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My likes recipes"
        recipes = DataManager.shared.fetchRecipes()
        setTableViewDelegates()
        configure()
        setConstraints()
        tableView.rowHeight = 140
        
    }
    
    func configure() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        title = "My likes recipes"
        tabBarItem.title = "Likes"
        tableView.register(LikeRecipeCell.self, forCellReuseIdentifier: "LikeRecipe")
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        recipes = DataManager.shared.fetchRecipes()
        tableView.reloadData()
    }
}

extension LikeRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeRecipe") as! LikeRecipeCell
        let recipe = recipes[indexPath.row]
        cell.set(recipe: recipe)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let recipe = recipes[indexPath.row]
        let recipeVC = RecipeScreenViewController()
        NetworkManager.shared.fetchRecipe(id: recipe.id) { recipe in
            recipeVC.setupUI(with: recipe)
        }
        navigationController?.pushViewController(recipeVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = recipes[indexPath.row]
            DataManager.shared.delete(recipe: recipe)
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
