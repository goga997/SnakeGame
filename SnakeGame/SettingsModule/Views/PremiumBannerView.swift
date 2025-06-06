//
//  PremiumBannerView.swift
//  SnakeGame
//
//  Created by Grigore on 19.05.2025.
//

import UIKit

class PremiumBannerView: UIView {
    
    private let iconLeft = UIImageView(image: UIImage(named: "LogoLaunchScreen"))
    private let iconRight = UIImageView(image: UIImage(systemName: "sparkles"))
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "premium_unlock".localized
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "premium_description".localized
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.white.withAlphaComponent(0.90)
        return label
    }()
    
    //initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        GradientHelper.applySettingsGradient(to: self)
    }
    
    // --------------------------------------------------------
    
    //for language
    func updateTexts() {
        titleLabel.text = "premium_unlock".localized
        subtitleLabel.text = "premium_description".localized
    }

    
    private func setupLayout() {
        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        
        let mainStack = UIStackView(arrangedSubviews: [iconLeft, textStack, iconRight])
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = 12
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        iconLeft.contentMode = .scaleAspectFit
        iconRight.contentMode = .scaleAspectFit
        iconRight.tintColor = .white
        
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            iconLeft.widthAnchor.constraint(equalToConstant: 36),
            iconLeft.heightAnchor.constraint(equalToConstant: 36),
            iconRight.widthAnchor.constraint(equalToConstant: 24),
            iconRight.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
