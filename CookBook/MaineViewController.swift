//
//  MaineViewController.swift
//  CookBook
//
//  Created by Лаванда on 28.02.2023.
//

import UIKit

class MaineViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet{
            ImageManager.shared.fetchImage(from: recipe?.image) { image in
                    self.imageView.image = image
            }
        }
    }
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        return image
    }()
        
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "No RECIPE"
        return label  
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setTitle("Go to Recire", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.shared.fetchRecipe(id: 715449) { recipe in
            self.recipe = recipe
            DispatchQueue.main.async {
                self.label.text = recipe.title
            }
        }
        view.backgroundColor = .white
        addView()
    }
    
    func addView() {
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(button)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        }
    
    @objc func buttonPressed() {
        let recipeVC = RecipeScreenViewController()
        NetworkManager.shared.fetchRecipe(id: 715562) { recipe in
            recipeVC.setupUI(with: recipe)
        }
        navigationController?.pushViewController(recipeVC, animated: true)
//        present(recipeVC, animated: true)
    }
}
