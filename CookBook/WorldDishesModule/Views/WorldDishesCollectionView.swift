//
//  WorldDishesCollectionView.swift
//  CookBook
//
//  Created by Эдгар Исаев on 28.02.2023.
//

import UIKit

struct CustomData {
    var name: String
    var image: UIImage
}

class WorldDishesCollectionView: UICollectionView {
    
    let data = [
       CustomData(name: "African", image: UIImage(named: "African") ?? UIImage()),
       CustomData(name: "American", image: UIImage(named: "American") ?? UIImage()),
       CustomData(name: "British", image: UIImage(named: "British") ?? UIImage()),
       CustomData(name: "Cajun", image: UIImage(named: "Cajun") ?? UIImage()),
       CustomData(name: "Caribbean", image: UIImage(named: "Caribbean") ?? UIImage()),
       CustomData(name: "Chinese", image: UIImage(named: "Chinese") ?? UIImage()),
       CustomData(name: "Eastern European", image: UIImage(named: "Eastern European") ?? UIImage()),
       CustomData(name: "European", image: UIImage(named: "European") ?? UIImage()),
       CustomData(name: "French", image: UIImage(named: "French") ?? UIImage()),
       CustomData(name: "German", image: UIImage(named: "German") ?? UIImage()),
       CustomData(name: "Greek", image: UIImage(named: "Greek") ?? UIImage()),
       CustomData(name: "Indian", image: UIImage(named: "Indian") ?? UIImage()),
       CustomData(name: "Irish", image: UIImage(named: "Irish") ?? UIImage()),
       CustomData(name: "Italian", image: UIImage(named: "Italian") ?? UIImage()),
       CustomData(name: "Japanese", image: UIImage(named: "Japanese") ?? UIImage()),
       CustomData(name: "Jewish", image: UIImage(named: "Jewish") ?? UIImage()),
       CustomData(name: "Korean", image: UIImage(named: "Korean") ?? UIImage()),
       CustomData(name: "Latin American", image: UIImage(named: "Latin American") ?? UIImage()),
       CustomData(name: "Mediterranean", image: UIImage(named: "Mediterranean") ?? UIImage()),
       CustomData(name: "Mexican", image: UIImage(named: "Mexican") ?? UIImage()),
       CustomData(name: "Middle Eastern", image: UIImage(named: "Middle Eastern") ?? UIImage()),
       CustomData(name: "Nordic", image: UIImage(named: "Nordic") ?? UIImage()),
       CustomData(name: "Southern", image: UIImage(named: "Southern") ?? UIImage()),
       CustomData(name: "Spanish", image: UIImage(named: "Spanish") ?? UIImage()),
       CustomData(name: "Thai", image: UIImage(named: "Thai") ?? UIImage()),
       CustomData(name: "Vietnamese", image: UIImage(named: "Vietnamese") ?? UIImage())
   ]
    
    var delegate2: DishesCollectionDelegate?
    let collectionLayout = UICollectionViewFlowLayout()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        setupLayout()
        configure()
        setDelegate()
        register(WorldDishesCollectionViewCell.self, forCellWithReuseIdentifier: WorldDishesCollectionViewCell.idDishesCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        collectionLayout.minimumInteritemSpacing = 2
    }
    
    private func configure() {
        bounces = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegate() {
        dataSource = self
        delegate = self
    }
}

//MARK: UICollectionViewDataSource

extension WorldDishesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: WorldDishesCollectionViewCell.idDishesCell,
                                             for: indexPath) as? WorldDishesCollectionViewCell else {
            return UICollectionViewCell()
            
        }

        cell.data = self.data[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dishes = data[indexPath.item].name
        print(dishes)
        delegate2?.presentVC(dishes: dishes)
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension WorldDishesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.frame.width * 0.486,
               height: self.frame.width * 0.3)
    }
}
