//
//  NotificationBannerView.swift
//  SnakeGame
//
//  Created by Grigore on 26.05.2025.
//

import UIKit

class LabeledSwitchView: UIView {
    
    private let titleLable = UILabel()
    private let toggleSwitch = UISwitch()
    private var onToggle: ((Bool) -> Void)?
    
    init(title: String, isOn: Bool = false, onToggle: ((Bool) -> Void)? = nil) {
        super.init(frame: .zero)
        self.onToggle = onToggle
        configure(title: title, isOn: isOn)
        setupLayout()
        layer.cornerRadius = 20
        backgroundColor = UIColor(white: 1, alpha: 0.8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(title: String, isOn: Bool) {
        titleLable.text = title
        titleLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLable.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        toggleSwitch.isOn = isOn
        toggleSwitch.onTintColor = #colorLiteral(red: 0.2, green: 0.5529411765, blue: 0.4941176471, alpha: 1)
        toggleSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        onToggle?(sender.isOn)
    }
    
    func setSwitchState(isOn: Bool) {
        toggleSwitch.setOn(isOn, animated: false)
    }
    
    private func setupLayout() {
        addSubview(titleLable)
        addSubview(toggleSwitch)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            
            titleLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            toggleSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            toggleSwitch.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
