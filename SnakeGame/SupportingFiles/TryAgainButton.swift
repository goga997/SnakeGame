//
//  GreenButton.swift
//  SnakeGame
//
//  Created by Grigore on 18.12.2023.
//

import UIKit

class TryAgainButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        setTitle(text, for: .normal)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.5465492606, green: 0.7540510297, blue: 0.5525836349, alpha: 1)
        titleLabel?.font = .fingerPaintFont22()
        tintColor = .white
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}
