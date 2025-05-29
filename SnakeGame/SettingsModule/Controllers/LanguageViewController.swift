//
//  LanguageViewController.swift
//  SnakeGame
//
//  Created by Grigore on 27.05.2025.
//

import UIKit

class LanguageViewController: UIViewController {
    
    private let languages: [String] = ["English", "Русский", "Español", "Français"]
    private let languageCodes: [String] = ["en", "ru", "es", "fr"]
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
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
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(backChevron)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "languageCell")
        
        NSLayoutConstraint.activate([
            backChevron.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            backChevron.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backChevron.heightAnchor.constraint(equalToConstant: 26),
            backChevron.widthAnchor.constraint(equalToConstant: 16),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func showChangeLabel() {
        let label = UILabel()
        label.text = "language_changed".localized
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.widthAnchor.constraint(equalToConstant: 200)
        ])

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            label.removeFromSuperview()
        }
    }

    @objc private func backTyped() {
        navigationController?.popViewController(animated: true)
    }
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        cell.textLabel?.text = languages[indexPath.row]
        
        let current = LocalizationManager.shared.currentLanguage
        if languageCodes[indexPath.row] == current.rawValue {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = LocalizationManager.Language(rawValue: languageCodes[indexPath.row]) ?? .english
        LocalizationManager.shared.currentLanguage = selectedLanguage

        showChangeLabel()
        tableView.reloadData()
    }
}
