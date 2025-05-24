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
        label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
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
    
    private let settingsTableView = SettingsTableView()
    
    
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
        
        view.addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.layer.cornerRadius = 20
        settingsTableView.clipsToBounds = true
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

// For UI implementation
extension SettingsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            
            premiumBannerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            premiumBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            premiumBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            premiumBannerView.heightAnchor.constraint(equalToConstant: 72),
            
            settingsTableView.topAnchor.constraint(equalTo: premiumBannerView.bottomAnchor, constant: 20),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsTableView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
