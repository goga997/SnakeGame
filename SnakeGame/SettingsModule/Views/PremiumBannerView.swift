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
        label.text = "Unlock Premium"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get unlimited hearts, avoid ads"
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
        applyGradientBackgroundForSettView()
    }
    
    // --------------------------------------------------------
    
    private func applyGradientBackgroundForSettView() {
        let gradientLayer = CAGradientLayer()
        
//        gradientLayer.colors = [
//            UIColor(hex: "#FCE38A").cgColor, // galben deschis
//            UIColor(hex: "#F38181").cgColor  // galben/apus puțin mai închis
//        ]
        
        gradientLayer.colors = [
            UIColor(hex: "#A0E6F5").cgColor, // galben deschis
            UIColor(hex: "#31AFC7").cgColor  // galben/apus puțin mai închis
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = bounds

        // Ensure there are no more layers added
        if let oldLayer = layer.sublayers?.first, oldLayer is CAGradientLayer {
            oldLayer.removeFromSuperlayer()
        }

        layer.insertSublayer(gradientLayer, at: 0)
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
