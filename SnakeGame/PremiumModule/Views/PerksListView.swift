//
//  PerksLabelView.swift
//  SnakeGame
//
//  Created by Grigore on 06.06.2025.
//

import UIKit

class PerksListView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        let perks = [
            "perk_one_premium".localized,
            "perk_unlimited_hearts".localized,
            "perk_offline_play".localized,
            "perk_all_boards".localized
        ]

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])

        for perk in perks {
            let icon = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
            icon.tintColor = .systemTeal
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.widthAnchor.constraint(equalToConstant: 26).isActive = true
            icon.heightAnchor.constraint(equalToConstant: 26).isActive = true

            let label = UILabel()
            label.text = perk
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.textColor = UIColor(named: "PremiumText") ?? .black
            label.numberOfLines = 0

            let hStack = UIStackView(arrangedSubviews: [icon, label])
            hStack.axis = .horizontal
            hStack.alignment = .center
            hStack.spacing = 8

            stackView.addArrangedSubview(hStack)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
