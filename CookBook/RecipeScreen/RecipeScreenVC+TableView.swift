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
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect())
        header.backgroundColor = .systemBackground
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = sections[section]
        header.addSubview(label)
        return header
    }
}

//MARK: - UITableViewDataSource
extension RecipeScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = sections[section]
        guard let ingredients = ingredientsList[currentSection] else { return 0 }
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeScreenTableViewCell.self), for: indexPath) as? RecipeScreenTableViewCell
        let currentSection = sections[indexPath.section]
        guard let ingredients = ingredientsList[currentSection] else { return UITableViewCell() }
        let amount = ingredients[indexPath.row].0
        let ingredient = ingredients[indexPath.row].1
        let ingredient = ingredientsList[indexPath.row]
        cell?.configure(with: ingredient, amount: "*")
        return cell ?? UITableViewCell()
    }
}
