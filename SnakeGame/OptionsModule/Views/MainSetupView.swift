//
//  MainSetupView.swift
//  SnakeGame
//
//  Created by Grigore on 18.12.2023.
//

import UIKit

class MainSetupView: UIView {
    
    private var controlBoardButtonStack = UIStackView()
    private var settingsButtonStackView = UIStackView()
    private let chooseBoardLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureControlBoardButtonStack()
        confchooseLabel()
        configureSettingsButtonStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func confchooseLabel() {
        chooseBoardLabel.text = "Choose Your\nBoard Size:"
        chooseBoardLabel.numberOfLines = 0
        chooseBoardLabel.textColor = .black
        //#colorLiteral(red: 0.8526944518, green: 0.2699841559, blue: 0.1734133065, alpha: 1)
        chooseBoardLabel.font = .fingerPaintFont18()
        chooseBoardLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chooseBoardLabel)
        NSLayoutConstraint.activate([
            chooseBoardLabel.bottomAnchor.constraint(equalTo: controlBoardButtonStack.topAnchor, constant: 20),
            chooseBoardLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            chooseBoardLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            chooseBoardLabel.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func configureControlBoardButtonStack() {
        let veryEasyButton = ControlBoardButton(text: "14 x 20")
        let easyButton = ControlBoardButton(text: "12 x 18")
        let mediumButton = ControlBoardButton(text: "10 x 14")
        let hardButton = ControlBoardButton(text: "8 x 10")
        let veryHarddButton = ControlBoardButton(text: "8 x 8")
        
        controlBoardButtonStack = UIStackView(arrangedSubviews: [veryEasyButton, easyButton, mediumButton, hardButton, veryHarddButton])
        
        controlBoardButtonStack.arrangedSubviews.enumerated().forEach { $0.element.tag = $0.offset }
        controlBoardButtonStack.axis = .vertical
        controlBoardButtonStack.spacing = 7
        controlBoardButtonStack.distribution = .fillEqually
        controlBoardButtonStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(controlBoardButtonStack)
        NSLayoutConstraint.activate([
            controlBoardButtonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            controlBoardButtonStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            controlBoardButtonStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            controlBoardButtonStack.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureSettingsButtonStackView() {
        let rulesButton = SettingButton(image: "grid")
        let giftButton = SettingButton(image: "gift")
        let likeButton = SettingButton(image: "square.and.arrow.up")
//        let gridButton = SettingButton(image: "grid")
        
        settingsButtonStackView = UIStackView(arrangedSubviews: [rulesButton, giftButton, likeButton])
        
        settingsButtonStackView.arrangedSubviews.enumerated().forEach { $0.element.tag = $0.offset }
        settingsButtonStackView.axis = .horizontal
        settingsButtonStackView.spacing = 20
        settingsButtonStackView.distribution = .fillEqually
        settingsButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(settingsButtonStackView)
        NSLayoutConstraint.activate([
            settingsButtonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            settingsButtonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            settingsButtonStackView.heightAnchor.constraint(equalToConstant: 50),
            settingsButtonStackView.widthAnchor.constraint(equalToConstant: 190),

        ])
    }
    
}
