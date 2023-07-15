//
//  UIImageView+Extension.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import UIKit

extension UIImageView {
    func loadImage(urlString: String,
                   placeholderImage: UIImage?,
                   errorImage: UIImage?) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        if let placeholder = placeholderImage {
            DispatchQueue.main.async {
                self.image = placeholder
            }
        }
        
        self.fetchImageFromNetwork(url: url,
                                   placeholderImage: placeholderImage,
                                   errorImage: errorImage)
    }
    
    private func fetchImageFromNetwork(url: URL,
                                       placeholderImage: UIImage?,
                                       errorImage: UIImage?) {
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error ) in
            if error != nil {
                if let errImage = errorImage {
                    DispatchQueue.main.async {
                        self?.image = errImage
                    }
                }
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if !(200...299).contains(statusCode) {
                if let errImage = errorImage {
                    DispatchQueue.main.async {
                        self?.image = errImage
                    }
                }
                return
            }
            
            if let self = self, let data = data, let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

