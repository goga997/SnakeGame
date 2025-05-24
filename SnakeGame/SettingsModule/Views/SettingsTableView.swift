//
//  SettingsTableView.swift
//  SnakeGame
//
//  Created by Grigore on 21.05.2025.
//

import UIKit

class SettingsTableView: UITableView {
    
    private let items: [(title: String, icon: UIImage?)] = [
        ("Language", UIImage(systemName: "globe")),
        ("Buy Hearts", UIImage(systemName: "heart.fill")),
        ("Reset Onboarding", UIImage(systemName: "arrow.counterclockwise")),
        ("Follow on Socials", UIImage(systemName: "person.2")),
        ("AppStore Review", UIImage(systemName: "star.fill"))
    ]
    
    init() {
        super.init(frame: .zero, style: .plain)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        delegate = self
        dataSource = self
        backgroundColor = .clear
        separatorStyle = .singleLine
        showsVerticalScrollIndicator = false
        isScrollEnabled = false
        
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseID)        
    }
    
}

extension SettingsTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: SettingsCell.reuseID, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configure(with: item.title, icon: item.icon)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Notify VC via delegate or closure if needed
    }
}
