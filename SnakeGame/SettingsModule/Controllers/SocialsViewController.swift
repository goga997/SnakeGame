//
//  SocialsViewController.swift
//  SnakeGame
//
//  Created by Grigore on 29.05.2025.
//

import UIKit

class SocialsViewController: UIViewController {
    private lazy var backChevron: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(backTyped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let instagramButton = createSocialButton(title: "Instagram", urlScheme: "instagram://user?username=goga997", webURL: "https://www.instagram.com/goga997")
        let facebookButton = createSocialButton(title: "Facebook", urlScheme: "fb://profile/123456789", webURL: "https://www.facebook.com/snakegame")
        let youtubeButton = createSocialButton(title: "YouTube", urlScheme: "youtube://www.youtube.com/@goga997", webURL: "https://www.youtube.com/@goga997")

        stackView.addArrangedSubview(instagramButton)
        stackView.addArrangedSubview(facebookButton)
        stackView.addArrangedSubview(youtubeButton)

        view.addSubview(backChevron)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            backChevron.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            backChevron.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backChevron.heightAnchor.constraint(equalToConstant: 26),
            backChevron.widthAnchor.constraint(equalToConstant: 16),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    private func createSocialButton(title: String, urlScheme: String, webURL: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(openSocialLink(_:)), for: .touchUpInside)
        button.accessibilityHint = "\(urlScheme)|\(webURL)"
        return button
    }

    @objc private func openSocialLink(_ sender: UIButton) {
        guard let hint = sender.accessibilityHint else { return }
        let components = hint.components(separatedBy: "|")
        guard components.count == 2 else { return }
        let scheme = components[0]
        let web = components[1]

        if let schemeURL = URL(string: scheme), UIApplication.shared.canOpenURL(schemeURL) {
            UIApplication.shared.open(schemeURL)
        } else if let webURL = URL(string: web) {
            UIApplication.shared.open(webURL)
        }
    }
    
    @objc private func backTyped() {
        navigationController?.popViewController(animated: true)
    }
}

