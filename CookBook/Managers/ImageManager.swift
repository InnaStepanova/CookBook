//
//  ImageManager.swift
//  CookBook
//
//  Created by Лаванда on 01.03.2023.
//

import UIKit

class ImageManager{
    
    static let shared = ImageManager()
    private init() {}
    
    func fetchImage(from imageUrl: String?, with completion: @escaping(UIImage) -> Void) {
        guard let stringUrl = imageUrl else {return}
        guard let url = URL(string: stringUrl) else {return}
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error)
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }.resume()
    }
}
