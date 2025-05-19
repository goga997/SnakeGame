//
//  SettingsViewController.swift
//  SnakeGame
//
//  Created by Grigore on 18.05.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fingerPaintFont26()
        label.textColor = #colorLiteral(red: 0.2605186105, green: 0.2605186105, blue: 0.2605186105, alpha: 1)
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let premiumBannerView = PremiumBannerView()
    
    let viewTest = UIView()
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        applyLaunchGradient(to: view)
        setUpView()
        setConstraints()
    }
    
    private func setUpView() {
        
        view .addSubview(titleLabel)
        view.addSubview(closeButton)
        
        premiumBannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(premiumBannerView)
        
        viewTest.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9647058824, alpha: 1)
        viewTest.layer.cornerRadius = 20
        viewTest.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTest)
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

// For UI implementation
extension SettingsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 28),
            closeButton.heightAnchor.constraint(equalToConstant: 28),
            
            premiumBannerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            premiumBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            premiumBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            premiumBannerView.heightAnchor.constraint(equalToConstant: 72),
            
            viewTest.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            viewTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewTest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewTest.heightAnchor.constraint(equalToConstant: 107),
            
        ])
    }
}
