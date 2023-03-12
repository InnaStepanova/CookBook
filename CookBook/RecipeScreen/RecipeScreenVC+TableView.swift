//
//  RecipeScreenVC + TableView.swift
//  CookBook
//
//  Created by Жадаев Алексей on 28.02.2023.
//

import UIKit

//MARK: - UITableViewDelegate
extension RecipeScreenViewController: UITableViewDelegate {
    ///set checkmark when user tapped a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath), isTableShowsIngredient else { return }
        let ingredient = ingredientsList[indexPath.row]
        if !isInToDoList(ingredient) {
            cell.accessoryType = .checkmark
            toDoList.append(ingredient)
            DataManager.shared.save(ingredient: ingredient)
        } else {
            cell.accessoryType = .none
            toDoList.removeAll{$0 == ingredient}
            DataManager.shared.delete(ingredient: ingredient)
        }
    }
    
    private func isInToDoList(_ ingredient: String) -> Bool {
        toDoList.contains(ingredient)
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView(frame: CGRect())
//        header.backgroundColor = .systemBackground
//        let label = UILabel()
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        header.addSubview(label)
//        return header
//    }
}

//MARK: - UITableViewDataSource
extension RecipeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeScreenTableViewCell.self), for: indexPath) as? RecipeScreenTableViewCell
        let ingredient = ingredientsList[indexPath.row]
        if isInToDoList(ingredient) {
            cell?.accessoryType = .checkmark
        }
        cell?.configure(with: ingredient)
        return cell ?? UITableViewCell()
    }
}
