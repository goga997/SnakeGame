//
//  SettingButton.swift
//  SnakeGame
//
//  Created by Grigore on 23.12.2023.
//

import UIKit

class SettingButton: UIButton {
    
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
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.5
        
    }
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.631372549, green: 0.7647058824, blue: 0.6745098039, alpha: 1)
        tintColor = .white
        contentMode = .scaleAspectFit
        addTarget(nil, action: #selector(SetupViewController.settingButtonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
