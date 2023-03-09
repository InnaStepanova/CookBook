//
//  MyViewController.swift
//  CustomCollectionCell
//
//  Created by Alexey Davidenko on 02.03.2023.
//

import UIKit

class MyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    
    let firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let thirdCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let fourthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let trendingLabel = UILabel()
    let recentLabel = UILabel()
    let popularCategoryLabel = UILabel()
    
    let seeAllButton = UIButton(type: .system)
    let secondSeeAllButton = UIButton(type: .system)
    
    let fullString = NSMutableAttributedString(string: "Trending now ")
    let image1Attachment = NSTextAttachment()
    
    let firstStack = UIStackView()
    let secondStack = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionViews
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        firstCollectionView.showsHorizontalScrollIndicator = false
        firstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //firstCollectionView.backgroundColor = .yellow
        firstCollectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: "FirstCustomCell")
        
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.showsHorizontalScrollIndicator = false
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //secondCollectionView.backgroundColor = .green
        secondCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: "SecondCustomCell")
        
        thirdCollectionView.dataSource = self
        thirdCollectionView.delegate = self
        thirdCollectionView.showsHorizontalScrollIndicator = false
        thirdCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //thirdCollectionView.backgroundColor = .blue
        thirdCollectionView.register(ThirdCollectionViewCell.self, forCellWithReuseIdentifier: "ThirdCustomCell")

        fourthCollectionView.dataSource = self
        fourthCollectionView.delegate = self
        fourthCollectionView.showsHorizontalScrollIndicator = false
        fourthCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //fourthCollectionView.backgroundColor = .red
        fourthCollectionView.register(FourthCollectionViewCell.self, forCellWithReuseIdentifier: "FourthCustomCell")
        
        //stacks
        firstStack.axis = .horizontal
        firstStack.translatesAutoresizingMaskIntoConstraints = false
        
        secondStack.axis = .horizontal
        secondStack.translatesAutoresizingMaskIntoConstraints = false
        
        //labels
        trendingLabel.text = "Trending now"
        trendingLabel.font = .systemFont(ofSize: 20, weight: .bold)
        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        popularCategoryLabel.text = "Popular category"
        popularCategoryLabel.font = .systemFont(ofSize: 20, weight: .bold)
        popularCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        recentLabel.text = "Recent recipe"
        recentLabel.font = .systemFont(ofSize: 20, weight: .bold)
        recentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        image1Attachment.image = UIImage(named: "flameImage")
        image1Attachment.bounds = CGRect(x: 0, y: -3, width: 25, height: 25)
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        trendingLabel.attributedText = fullString
        
        //buttons
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.setTitleColor(.systemRed, for: .normal)
        seeAllButton.contentMode = .scaleAspectFill
        seeAllButton.clipsToBounds = true
        seeAllButton.addTarget(self, action: #selector(firstButtonTapped(_ :)), for: .touchUpInside)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        secondSeeAllButton.setTitle("See all", for: .normal)
        secondSeeAllButton.setTitleColor(.systemRed, for: .normal)
        secondSeeAllButton.contentMode = .scaleAspectFill
        secondSeeAllButton.clipsToBounds = true
        secondSeeAllButton.addTarget(self, action: #selector(secondButtonTapped(_ :)), for: .touchUpInside)
        secondSeeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.83)
        firstCollectionView.collectionViewLayout = layout

        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        layout2.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.20, height: UIScreen.main.bounds.width * 0.60)
        secondCollectionView.collectionViewLayout = layout2

        let layout3 = UICollectionViewFlowLayout()
        layout3.scrollDirection = .horizontal
        layout3.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.width * 0.50)
        thirdCollectionView.collectionViewLayout = layout3

        let layout4 = UICollectionViewFlowLayout()
        layout4.scrollDirection = .horizontal
        layout4.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.33, height: UIScreen.main.bounds.width * 0.55)
        fourthCollectionView.collectionViewLayout = layout4
        
        view.addSubview(firstStack)
        firstStack.addArrangedSubview(trendingLabel)
        firstStack.addArrangedSubview(seeAllButton)
        view.addSubview(secondStack)
        secondStack.addArrangedSubview(recentLabel)
        secondStack.addArrangedSubview(secondSeeAllButton)
        view.addSubview(popularCategoryLabel)
        view.addSubview(firstCollectionView)
        view.addSubview(secondCollectionView)
        view.addSubview(thirdCollectionView)
        view.addSubview(fourthCollectionView)

        
        NSLayoutConstraint.activate([
            
            firstStack.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
            firstStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            firstStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            firstCollectionView.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 15),
            firstCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            firstCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //firstCollectionView.heightAnchor.constraint(equalTo: firstCollectionView.widthAnchor, multiplier: 0.85),
            firstCollectionView.heightAnchor.constraint(equalTo: firstCollectionView.widthAnchor, multiplier: 0.1),
            
            popularCategoryLabel.topAnchor.constraint(equalTo: firstCollectionView.bottomAnchor, constant: 5),
            popularCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            secondCollectionView.topAnchor.constraint(equalTo: popularCategoryLabel.bottomAnchor, constant: 15),
            secondCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            secondCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            thirdCollectionView.topAnchor.constraint(equalTo: secondCollectionView.bottomAnchor, constant: 15),
            thirdCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            thirdCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thirdCollectionView.heightAnchor.constraint(equalTo: thirdCollectionView.widthAnchor, multiplier: 0.55),

            secondStack.topAnchor.constraint(equalTo: thirdCollectionView.bottomAnchor, constant: 5),
            secondStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            secondStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            fourthCollectionView.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 5),
            fourthCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            fourthCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fourthCollectionView.heightAnchor.constraint(equalTo: fourthCollectionView.widthAnchor, multiplier: 0.6)
        ])
    }
    
    @objc func firstButtonTapped(_ sender: UIButton) {
        print("First See All button clicked")
    }
    
    @objc func secondButtonTapped(_ sender: UIButton) {
        print("Second See All button clicked")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnValue = 0
        
        if collectionView == firstCollectionView {
            returnValue = 5
        }
        
        if collectionView == secondCollectionView {
            returnValue = 15
        }

        if collectionView == thirdCollectionView {
            returnValue = 5
        }

        if collectionView == fourthCollectionView {
            returnValue = 5
        }
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == firstCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCustomCell", for: indexPath) as! FirstCollectionViewCell
            return cell
        } else if collectionView == secondCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCustomCell", for: indexPath) as! SecondCollectionViewCell
            return cell
        } else if collectionView == thirdCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCustomCell", for: indexPath) as! ThirdCollectionViewCell
            return cell
        } else if collectionView == fourthCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthCustomCell", for: indexPath) as! FourthCollectionViewCell
            return cell
        } else {
            preconditionFailure("Unknown collection view!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}
