//
//  MainPremiumView.swift
//  SnakeGame
//
//  Created by Grigore on 05.06.2025.
//

import UIKit

class TopPremiumView: UIView {
    
    private let logoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.56
        view.layer.shadowOffset = CGSize(width: 1, height: 4)
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LogoLaunchScreen"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let upgradeLabel: UILabel = {
        let label = UILabel()
        label.text = "upgrade_to".localized
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Snake Escape Pro"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)
        addSubview(upgradeLabel)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            logoContainer.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            logoContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoContainer.widthAnchor.constraint(equalToConstant: 100),
            logoContainer.heightAnchor.constraint(equalToConstant: 100),
            
            logoImageView.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: logoContainer.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 84),
            logoImageView.heightAnchor.constraint(equalToConstant: 84),
            
            upgradeLabel.topAnchor.constraint(equalTo: logoContainer.bottomAnchor, constant: 30),
            upgradeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: upgradeLabel.bottomAnchor, constant: 2),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
