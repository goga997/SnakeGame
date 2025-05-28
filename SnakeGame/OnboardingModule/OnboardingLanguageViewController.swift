//
//  OnboardingLanguageViewController.swift
//  SnakeGame
//
//  Created by Grigore on 27.05.2025.
//

import UIKit

class OnboardingLanguageViewController: UIViewController {
    
    private let languages: [LocalizationManager.Language] = [.english, .russian, .spanish, .french]
    private var languageButtons: [UIButton] = []
    
    private var selectedLanguage: LocalizationManager.Language? {
        didSet {
            let isSelected = selectedLanguage != nil
            nextButton.isEnabled = isSelected
            UIView.animate(withDuration: 0.25) {
                self.nextButton.alpha = isSelected ? 1.0 : 0.7
            }
            updateLanguageSelectionUI()
            languageTitleLabel.text = "choose_language_title".localized
        }
    }
    
    private let languageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "choose_language_title".localized
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 2. Next Button
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("next_onboarding".localized, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.isEnabled = false
        button.alpha = 0.3
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: .languageChanged, object: nil)
    }
    
    private func setupLayout() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for lang in languages {
            let button = UIButton(type: .system)
            button.setTitle(lang.displayName, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.layer.cornerRadius = 25
            button.backgroundColor = .systemTeal
            button.tintColor = .white
            button.tag = languages.firstIndex(of: lang)!
            button.addTarget(self, action: #selector(languageTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true // Height fix
            stackView.addArrangedSubview(button)
            languageButtons.append(button)
        }
        
        view.addSubview(languageTitleLabel)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            languageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            languageTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            languageTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            stackView.topAnchor.constraint(equalTo: languageTitleLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func languageTapped(_ sender: UIButton) {
        let lang = languages[sender.tag]
        LocalizationManager.shared.currentLanguage = lang
        selectedLanguage = lang
        NotificationCenter.default.post(name: .languageChanged, object: nil)
    }
    
    @objc private func nextTapped() {
        (parent as? OnboardingViewController)?.goToNextPage()
    }
    
    // 3 + 5. Rămâne marcat vizual și highlight
    private func updateLanguageSelectionUI() {
        for (index, button) in languageButtons.enumerated() {
            if languages[index] == selectedLanguage {
                button.backgroundColor = .systemTeal
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .secondarySystemBackground
                button.setTitleColor(.label, for: .normal)
            }
        }
    }
    
    // 4. Update instant pentru label când se schimbă limba
    @objc private func languageChanged() {
        nextButton.setTitle("next_onboarding".localized, for: .normal)
        languageTitleLabel.text = "choose_language_title".localized
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
