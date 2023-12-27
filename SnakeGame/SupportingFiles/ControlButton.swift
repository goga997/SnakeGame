//
//  ControlButton.swift
//  SnakeGame
//
//  Created by Grigore on 18.12.2023.
//

import UIKit

class ControlButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(image: String) {
        self.init(type: .system)
        setImage(UIImage(systemName: image), for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
    }
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.7254901961, blue: 0.6666666667, alpha: 1)
        tintColor = .black
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
