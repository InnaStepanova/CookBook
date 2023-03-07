//
//  RecipeScreenViewController.swift
//  CookBook
//
//  Created by Жадаев Алексей on 28.02.2023.
//

import UIKit

final class RecipeScreenViewController: UIViewController {
    //MARK: - Properties
    private(set) var ingredientsList: [String] = []
    private(set) var instructions: [String] = []
    private(set) var ingredients: [String] = []
    private(set) var isTableShowsIngredient: Bool = true
    var toDoList: [String] = []
    var isFavorite: Bool = false
    
    private let topImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        if isFavorite {
            button.setImage(UIImage(named: "tappedHeart"), for: .normal)
        } else {
            button.setImage(UIImage(named: "heart"), for: .normal)
        }
        button.tintColor = Resources.Colors.red
        button.backgroundColor = Resources.Colors.pink
        return button
    }()
    private let sheetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemBackground
        return view
    }()
    private let timerImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "timer")
        view.tintColor = Resources.Colors.red
        return view
    }()
    private let cookingTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Resources.Colors.red
        return label
    }()
    private let pricePerServing: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Resources.Colors.red
        return label
    }()
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.pink
        return view
    }()
    private let ingredientButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ingredient", for: .normal)
        button.tintColor = .systemBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = Resources.Colors.red
        return button
    }()
    private let directionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Direction", for: .normal)
        button.tintColor = .systemBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = Resources.Colors.red
        return button
    }()
    
    //MARK: - UIStackViews
    private lazy var cookingTimeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timerImage, cookingTime])
        stack.distribution = .fillProportionally
        stack.alignment = .firstBaseline
        stack.spacing = 5
        return stack
    }()
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ingredientButton, directionButton])
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cookingTimeStack, pricePerServing, separator, buttonsStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
    //MARK: - UITableView
    private let recipeTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RecipeScreenTableViewCell.self, forCellReuseIdentifier: String(describing: RecipeScreenTableViewCell.self))
        table.separatorStyle = .none
        return table
    }()

    //MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeButtonRound(favoriteButton)
    }
    
    //MARK: - Actions
    @objc private func ingredientButtonPressed(_ sender: UIButton) {
        guard !isTableShowsIngredient else { return }
        isTableShowsIngredient.toggle()
        updateTable()
    }
    
    @objc private func directionButtonPressed(_ sender: UIButton) {
        guard isTableShowsIngredient else { return }
        isTableShowsIngredient.toggle()
        updateTable()
    }
    
    @objc private func likeButtonPressed(_ sender: UIButton) {
        isFavorite.toggle()
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "tappedHeart"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        buttonGrowingEffect(sender)
    }
    
    //MARK: - Updating data
    private func updateTable() {
        if isTableShowsIngredient {
            ingredientsList = ingredients
            recipeTableView.allowsSelection = true
        } else {
            ingredientsList = instructions
            recipeTableView.allowsSelection = false
        }
        recipeTableView.reloadData()
    }
    
    //MARK: - Setup UI
    func setupUI(with recipe: Recipe) {
        ImageManager.shared.fetchImage(from: recipe.image) { image in
            self.topImage.image = image
        }
        guard let cookingMinutes = recipe.cookingMinutes else { return }
        guard let price = recipe.pricePerServing else { return }
        guard let instruction = recipe.instructions else { return }
        title = recipe.title
        cookingTime.text = "\(String(describing: cookingMinutes)) minutes"
        pricePerServing.text = "Price per serving: \(String(describing: price))$"
        ingredients = recipe.extendedIngredients.map { "\($0.original ?? "")" }
        instructions = instruction.components(separatedBy: "</li><li>")
        recipeTableView.showsVerticalScrollIndicator = false
        updateTable()
        setupTargets()
        setupConstraints()
    }
    
    private func setupTargets() {
        ingredientButton.addTarget(self, action: #selector(ingredientButtonPressed(_:)), for: .touchUpInside)
        directionButton.addTarget(self, action: #selector(directionButtonPressed(_:)), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(likeButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        view.addSubview(topImage)
        view.addSubview(sheetView)
        view.addSubview(favoriteButton)
        view.addSubview(mainStack)
        view.addSubview(recipeTableView)
        NSLayoutConstraint.activate([
            topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topImage.bottomAnchor.constraint(equalTo: sheetView.topAnchor, constant: 20),
            
            favoriteButton.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -20),
            favoriteButton.centerYAnchor.constraint(equalTo: sheetView.topAnchor, constant: -5),

            sheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sheetView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            buttonsStack.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor),
            
            mainStack.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            mainStack.topAnchor.constraint(equalTo: sheetView.topAnchor),
            mainStack.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            mainStack.heightAnchor.constraint(equalTo: sheetView.heightAnchor, multiplier: 0.35),
            
            recipeTableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 10),
            recipeTableView.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 20),
            recipeTableView.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -20),
            recipeTableView.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor),
            
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 7),
            separator.heightAnchor.constraint(equalToConstant: 2),
            separator.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
        ])
    }
    
    private func buttonGrowingEffect(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = CGAffineTransform.identity
            })
        })
    }
    
    private func makeButtonRound(_ button: UIButton) {
        button.layer.cornerRadius = favoriteButton.bounds.size.width / 2
        button.clipsToBounds = true
    }
}
