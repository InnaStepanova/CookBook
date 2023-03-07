//
//  RecipeScreenViewController.swift
//  CookBook
//
//  Created by Жадаев Алексей on 28.02.2023.
//

import UIKit

enum MockData {
    static let name = "Seblak Bandung"
    static let description = "Seblak dengan beberapa kerupuk ikan ditambah dengan tangkar daging ayam"
    static let ingredientsList = [
        "Serves 2-4 people": [("300 g", "chicken feet, boiled for 20 mins"), ("2 pcs", "beef sausage"), ("5 pcs", "beef meatballs"), ("1 egg", "beaten")],
        "For the spice paste": [("15 g", "garlic"), ("3 g", "shrimp paste"), ("25 g", "shallots"), ("50 g", "aromatic ginger")]]
    static let ingredientsSections = ["Serves 2-4 people", "For the spice paste"]
    static let directionList = [
        "1   Prepare the spice paste": [("*", "In a food processor, blend the garlic, shallots, aromatic ginger, big red chili, red chili peppers and shrimp paste")],
        "2   Cook the chicken feet": [("*", "In a pan on medium heat, saute the spice paste until fragrant, or until released, stirring constantly"), ("*", "To the pan, add water, salt, sugar and chicken powder"), ("*", "Slice or dice the sausages and meatballs then add to the pan"), ("*", "Add the chicken feet and boiled crackers, bring to a boil"), ("*", "After the water has reached boiling temperature, add the mustard greens. Mix well to combine"), ("*", "Add beaten egg while continuing to stir until the liquid thickens"), ("*", "Remove from heat")],
        "3   Plate and Serve!": [("*", "Pour the chicken feet into your serving bowl, garnish with fried onions and serve.")]]
    static let directionSections = ["1   Prepare the spice paste", "2   Cook the chicken feet", "3   Plate and Serve!"]
    static let rating = 4.8
    static let reviews = 100
    static let authorPhoto = UIImage(systemName: "person.crop.circle")
    static let authorName = "Wade Warren"
    static let authorTitle = "Masterchef Indonesia"
}

final class RecipeScreenViewController: UIViewController {
    //MARK: - Properties
//    var recipe: Recipe? {
//        didSet {
//            title = recipe?.title
//            recipeName.text = recipe?.title
//            ImageManager.shared.fetchImage(from: recipe?.image) { image in
//                self.topImage.image = image
//            }
//        }
//    }
   
    private(set) var ingredientsList: [String: [String]] = [:]
//    private(set) var ingredientsList: [String] = []
    private(set) var sections: [String] = []
    private(set) var isTableShowsIngredient: Bool = true
    private(set) var instructions: [String] = []
    private(set) var ingredients: [String] = []
    
    private let topImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.circle"), for: .normal)
        button.setImage(UIImage(systemName: "heart.circle.fill"), for: .highlighted)
        button.tintColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 242/255, green: 144/255, blue: 123/255, alpha: 1)
        return button
    }()
    private let sheetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    private let recipeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let starImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "timer")
        view.tintColor = .systemYellow
        return view
    }()
    private let recipeRating: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textColor = .systemYellow
        return label
    }()
    private let reviewsAmount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemYellow
        return label
    }()
    private let recipeDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let authorPhoto: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = view.bounds.size.width / 2
        view.tintColor = .systemGray
        return view
    }()
    private let authorName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private let authorTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    private let ingredientButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ingredient", for: .normal)
        button.tintColor = .systemBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBrown
        return button
    }()
    private let directionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Direction", for: .normal)
        button.tintColor = .systemBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBrown
        return button
    }()
    
    //MARK: - UIStackViews
    private lazy var ratingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starImage, recipeRating, reviewsAmount])
        stack.distribution = .fillProportionally
        stack.alignment = .firstBaseline
        stack.spacing = 5
        return stack
    }()
    private lazy var nameAndRatingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [recipeName, ratingStack])
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 50
        return stack
    }()
    private lazy var authorVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [authorName, authorTitle])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 3
        return stack
    }()
    private lazy var authorHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [authorPhoto, authorVerticalStack])
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ingredientButton, directionButton])
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 2
        return stack
    }()
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameAndRatingStack, recipeDescription, authorHorizontalStack, separator, buttonsStack])
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
        view.backgroundColor = .white
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
//        setupUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeButtonRound(likeButton)
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
    }
    
    //MARK: - Updating data
    private func updateTable() {
        if isTableShowsIngredient {
            ingredientsList = ingredients
            sections = MockData.ingredientsSections
            recipeTableView.allowsSelection = true
        } else {
            ingredientsList = instructions
            sections = MockData.directionSections
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
        guard var instruction = recipe.instructions else { return }
        instruction.removeFirst(8)
        instruction.removeLast(10)
        title = recipe.title
        recipeRating.text = "(\(String(describing: cookingMinutes)) minutes)"
        recipeDescription.text = "(Price per serving: \(String(describing: price))"
        ingredients = recipe.extendedIngredients.map{String(describing: $0.original ?? "")}
        instructions = instruction.components(separatedBy: "</li><li>")
        
        print(instructions)
        recipeTableView.showsVerticalScrollIndicator = false
        updateTable()
        setupTargets()
        setupConstraints()
    }
    
    private func setupTargets() {
        ingredientButton.addTarget(self, action: #selector(ingredientButtonPressed(_:)), for: .touchUpInside)
        directionButton.addTarget(self, action: #selector(directionButtonPressed(_:)), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        view.addSubview(topImage)
        view.addSubview(sheetView)
        view.addSubview(likeButton)
        view.addSubview(mainStack)
        view.addSubview(recipeTableView)
        NSLayoutConstraint.activate([
            topImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topImage.bottomAnchor.constraint(equalTo: sheetView.topAnchor, constant: 20),
            
            likeButton.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -40),
            likeButton.centerYAnchor.constraint(equalTo: sheetView.topAnchor, constant: -5),

            sheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sheetView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            
            buttonsStack.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor),
            
            mainStack.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            mainStack.topAnchor.constraint(equalTo: sheetView.topAnchor),
            mainStack.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            mainStack.heightAnchor.constraint(equalTo: sheetView.heightAnchor, multiplier: 0.4),
            
            recipeTableView.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 10),
            recipeTableView.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 20),
            recipeTableView.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -20),
            recipeTableView.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor),
            
            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 8),
            authorPhoto.heightAnchor.constraint(equalTo: authorPhoto.widthAnchor),
            authorPhoto.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 6),
            separator.heightAnchor.constraint(equalToConstant: 2),
            separator.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
        ])
    }
    
    private func makeButtonRound(_ button: UIButton) {
        button.layer.cornerRadius = likeButton.bounds.size.width / 2
        button.clipsToBounds = true
    }
}
