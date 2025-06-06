//
//  UIComponents.swift
//  SnakeGame
//
//  Created by Grigore on 18.02.2025.
//

import UIKit

class UIComponents {
    
    static func createHeartImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.8078, green: 0.1843, blue: 0.1333, alpha: 1.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func createLockImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.8078, green: 0.1843, blue: 0.1333, alpha: 1.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
