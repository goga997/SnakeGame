//
//  UILabelExtension.swift
//  SnakeGame
//
//  Created by Grigore on 18.12.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()
        self.text = text
        self.font = .fingerPaintFont14()
        self.textColor = .black
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(text: String = "", font: UIFont?, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(text28: String) {
        self.init()
        self.text = text28
        self.font = .fingerPaintFont28()
        self.textColor = .black
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
