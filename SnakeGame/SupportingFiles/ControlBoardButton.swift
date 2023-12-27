//
//  LevelButton.swift
//  SnakeGame
//
//  Created by Grigore on 18.12.2023.
//

import UIKit

class ControlBoardButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont.fingerPaintFont16()
    }
    
    private func configure() {
        backgroundColor = .systemTeal
        layer.cornerRadius = 10
        tintColor = .white
        addTarget(nil, action: #selector(SetupViewController.levelButtonTapped), for: .touchUpInside)
    }
}
