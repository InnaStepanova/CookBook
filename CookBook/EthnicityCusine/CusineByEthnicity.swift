//
//  CusineByEthnicity.swift
//  CookBook
//
//  Created by Даниил Петров on 01.03.2023.
//

import Foundation
import  UIKit

class EthnicityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "da"
    }
}
//
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        title = "das"
//        scrollView.backgroundColor = .white
//        scrollView.frame = view.bounds
//        scrollView.contentSize = contentSize
//
//
//        return scrollView
//    }()
//
//
//    private lazy var contentView: UIView = {
//        let contentView = UIView()
//        contentView.backgroundColor = .white
//        contentView.frame.size = contentSize
//        return contentView
//    }()
//
//    private let stackView: UIStackView = {
//        let stackView = UIStackView()
//
//
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.spacing = 20
//        return stackView
//    }()
//
//    private var contentSize: CGSize {
//        CGSize(width: view.frame.width, height: view.frame.height + 400)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(stackView)
//        view.backgroundColor = .white
//        self.navigationItem.title = "Your Title"
//
//        setupColors()
//        setupViewsConstraints()
//    }
//
//}
//
//extension EthnicityViewController {
//    private func setupViewsConstraints() {
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//        ])
//
//        for view in stackView.arrangedSubviews {
//            NSLayoutConstraint.activate([
//                view.widthAnchor.constraint(equalToConstant: 300),
//                view.heightAnchor.constraint(equalToConstant: 100)])
//        }
//    }
//
//    private func setupColors() {
//        let colors = [UIColor.red, .green, .blue]
//
//        for index in 0..<10 {
//            let view = UIView()
//            view.backgroundColor = colors[index % colors.count]
//            stackView
//                .addArrangedSubview(view)
//        }
//    }
//}
