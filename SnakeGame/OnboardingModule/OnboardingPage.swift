//
//  OnboardingInfoViewController.swift
//  SnakeGame
//
//  Created by Grigore on 27.05.2025.
//

import UIKit

class OnboardingPage: UIViewController {

    private let imageName: String
    private let titleText: String
    private let descriptionText: String
    private let isLastPage: Bool

    init(imageName: String, titleText: String, descriptionText: String, isLastPage: Bool = false) {
        self.imageName = imageName
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.isLastPage = isLastPage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let nextButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        updateTexts()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTexts), name: .languageChanged, object: nil)
    }

    private func setupLayout() {
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 4
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        nextButton.backgroundColor = .systemTeal
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 25
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func updateTexts() {
        titleLabel.text = titleText.localized
        descriptionLabel.text = descriptionText.localized
        nextButton.setTitle(isLastPage ? "start_game".localized : "next_onboarding".localized, for: .normal)
    }

    @objc private func nextTapped() {
        if isLastPage {
            UserDefaults.standard.set(true, forKey: "onboardingShown")

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate,
               let window = delegate.window {
                window.rootViewController = SetupViewController()
                window.makeKeyAndVisible()
            }
        } else {
            (parent as? OnboardingViewController)?.goToNextPage()
        }
    }

}

