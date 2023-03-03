//
//  StartViewController.swift
//  CookBook
//
//  Created by Aleksandr Garipov on 27.02.2023.
//

import UIKit

final class StartViewController: UIViewController {

    //MARK: - StarteButton
    var startButton: UIButton = {
        var button = UIButton()
        button = UIButton(type: .roundedRect)
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        button.setTitle("Get Started", for: .normal)
        button.setTitle("Start!", for: .highlighted)
        button.layer.cornerRadius = 8
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - backgroundImage
    var backgroundImage: UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = UIImage(named: "startBgImage")
        image.contentMode =  UIView.ContentMode.scaleAspectFill
        return image
    }()
    
    
        //MARK: - findBestRecipesLabel
    let findBestRecipesLabel: UILabel = {
        var label = UILabel()
        label.text = "Find best recipes for cooking"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - cook#WithMe
    let cookWithMeLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = """
        cook
        #WithMe
        """
        label.font = UIFont.systemFont(ofSize: 56)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - PremiumRecipes
    let premiumRecipes: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "100K+ Premium recipes"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starImage: UIImageView = {
        let systemImage = UIImage(systemName: "star.fill")
        let image = UIImageView(image: systemImage)
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [starImage, premiumRecipes])
        stack.spacing = 9
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layout()
    }
    
    func setupUI() {
        view.addSubview(backgroundImage)
        setupGradient()
        view.addSubview(startButton)
        view.addSubview(findBestRecipesLabel)
        view.addSubview(cookWithMeLabel)
        view.addSubview(stackView)
    }
    
    
    
    func layout() {
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -82).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 156).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        findBestRecipesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        findBestRecipesLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -32).isActive = true

        cookWithMeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cookWithMeLabel.bottomAnchor.constraint(equalTo: findBestRecipesLabel.topAnchor, constant: -15).isActive = true

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true

        starImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    func setupGradient() {
        let colorTop = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let colorBot = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [colorTop, colorBot]
        gradientLayer.locations = [0.5, 1]
        view.layer.addSublayer(gradientLayer)
    }
    
    @objc func startButtonPressed(sender: UIButton) {
        let tabBarVC = UINavigationController(rootViewController: TabBarController())
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
}

