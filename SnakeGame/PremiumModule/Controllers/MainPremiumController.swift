//
//  MainPremiumController.swift
//  SnakeGame
//
//  Created by Grigore on 05.06.2025.
//

import UIKit

class MainPremiumController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        GradientHelper.applySettingsGradient(to: topSection)
    }
    
    private let topSection = UIView()
    private let bottomSection = UIView()
    private let cancelButton = UIButton(type: .system)
    private let topElementsStack = TopPremiumView()
    private let perksList = PerksListView()

    private func setupLayout() {
        setupTopSection()
        setupBottomSection()
        setupCancelButton()
    }

    private func setupTopSection() {
        topSection.clipsToBounds = true
        topSection.layer.cornerRadius = 86
        topSection.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        topSection.translatesAutoresizingMaskIntoConstraints = false
        topElementsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topSection)
        topSection.addSubview(topElementsStack)

        NSLayoutConstraint.activate([
            topSection.topAnchor.constraint(equalTo: view.topAnchor),
            topSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40),
            
            topElementsStack.topAnchor.constraint(equalTo: topSection.topAnchor, constant: 80),
            topElementsStack.leadingAnchor.constraint(equalTo: topSection.leadingAnchor, constant: 40),
            topElementsStack.trailingAnchor.constraint(equalTo: topSection.trailingAnchor, constant: -40),
            topElementsStack.bottomAnchor.constraint(equalTo: topSection.bottomAnchor, constant: -20),
        ])
    }

    private func setupBottomSection() {
        bottomSection.backgroundColor = .white
        bottomSection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSection)

        perksList.translatesAutoresizingMaskIntoConstraints = false
        bottomSection.addSubview(perksList)

        NSLayoutConstraint.activate([
            bottomSection.topAnchor.constraint(equalTo: topSection.bottomAnchor),
            bottomSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSection.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            perksList.topAnchor.constraint(equalTo: bottomSection.topAnchor, constant: 2),
            perksList.leadingAnchor.constraint(equalTo: bottomSection.leadingAnchor, constant: 10),
            perksList.trailingAnchor.constraint(equalTo: bottomSection.trailingAnchor, constant: -10)
        ])
        
        let purchaseStack = UIStackView()
        purchaseStack.axis = .vertical
        purchaseStack.spacing = 6
        purchaseStack.alignment = .fill
        purchaseStack.translatesAutoresizingMaskIntoConstraints = false

        let yearlyButton = UIButton(type: .system)
        yearlyButton.setTitle("premium_yearly".localized, for: .normal)
        yearlyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        yearlyButton.setTitleColor(.white, for: .normal)
        yearlyButton.backgroundColor = .systemTeal
        yearlyButton.layer.cornerRadius = 24
        yearlyButton.heightAnchor.constraint(equalToConstant: 48).isActive = true

        let orLabel = UILabel()
        orLabel.text = "or".localized
        orLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        orLabel.textAlignment = .center
        orLabel.textColor = .systemTeal

        let lifetimeButton = UIButton(type: .system)
        lifetimeButton.setTitle("premium_lifetime".localized, for: .normal)
        lifetimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lifetimeButton.setTitleColor(.systemTeal, for: .normal)
        lifetimeButton.backgroundColor = .clear
        lifetimeButton.layer.borderColor = UIColor.systemTeal.cgColor
        lifetimeButton.layer.borderWidth = 1
        lifetimeButton.layer.cornerRadius = 24
        lifetimeButton.heightAnchor.constraint(equalToConstant: 48).isActive = true

        let restoreButton = UIButton(type: .system)
        restoreButton.setTitle("restore_purchase".localized, for: .normal)
        restoreButton.setTitleColor(.systemTeal, for: .normal)

        purchaseStack.addArrangedSubview(yearlyButton)
        purchaseStack.addArrangedSubview(orLabel)
        purchaseStack.addArrangedSubview(lifetimeButton)
        // purchaseStack.addArrangedSubview(restoreButton) // Removed as a bit down

        bottomSection.addSubview(purchaseStack)

        NSLayoutConstraint.activate([
            purchaseStack.topAnchor.constraint(equalTo: perksList.bottomAnchor, constant: 8),
            purchaseStack.leadingAnchor.constraint(equalTo: bottomSection.leadingAnchor, constant: 40),
            purchaseStack.trailingAnchor.constraint(equalTo: bottomSection.trailingAnchor, constant: -40)
        ])

        bottomSection.addSubview(restoreButton)
        restoreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restoreButton.topAnchor.constraint(equalTo: purchaseStack.bottomAnchor, constant: 16),
            restoreButton.centerXAnchor.constraint(equalTo: bottomSection.centerXAnchor)
        ])
    }

    private func setupCancelButton() {
        cancelButton.setTitle("cancel".localized, for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        cancelButton.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        topSection.addSubview(cancelButton)

        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topSection.safeAreaLayoutGuide.topAnchor, constant: 4),
            cancelButton.leadingAnchor.constraint(equalTo: topSection.leadingAnchor, constant: 16)
        ])
    }
    
    @objc private func cancelBtnTapped() {
        HapticsManager.shared.impactFeedback(for: .soft)
        dismiss(animated: true)
    }
    
}
