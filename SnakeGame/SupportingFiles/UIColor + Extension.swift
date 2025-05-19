//
//  UIColor + Extension.swift
//  SnakeGame
//
//  Created by Grigore on 19.05.2025.
//

import UIKit

func applyLaunchGradient(to view: UIView) {
    let gradient = CAGradientLayer()
    gradient.frame = view.bounds
    gradient.colors = [
        UIColor(hex: "#FFFCEF").cgColor,
        UIColor(hex: "#98C5AA").cgColor
    ]
    gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
    gradient.locations = [0.0, 0.65]

    view.layer.insertSublayer(gradient, at: 0)
}


extension UIColor {
    convenience init(hex: String) {
            var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if hexFormatted.hasPrefix("#") {
                hexFormatted.remove(at: hexFormatted.startIndex)
            }
            
            var rgbValue: UInt64 = 0
            Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255
            let blue = CGFloat(rgbValue & 0x0000FF) / 255

            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        }
}
