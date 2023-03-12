//
//  ToDoListVC.swift
//  CookBook
//
//  Created by Жадаев Алексей on 11.03.2023.
//

import UIKit

final class ToDoListViewController: UIViewController {
    private var tableView = UITableView()
    private var ingredients: [String] = []
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegates()
        configure()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ingredients = DataManager.shared.fetchIngredients()
        tableView.reloadData()
    }
    
    //MARK: - Setup UI
    
    private func configure() {
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        title = "Ingredients to buy"
        tabBarItem.title = "ToDo"
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: String(describing: ToDoListCell.self))
        tableView.rowHeight = 40
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoListCell.self)) as? ToDoListCell else { return UITableViewCell() }
        let ingredient = ingredients[indexPath.row]
        cell.set(ingredient: ingredient)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ingredient = ingredients[indexPath.row]
            DataManager.shared.delete(ingredient: ingredient)
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
