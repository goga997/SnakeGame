//
//  AppPoliciesTableView.swift
//  SnakeGame
//
//  Created by Grigore on 26.05.2025.
//

import UIKit

protocol AppPoliciesTableViewDelegate: AnyObject {
    func didSelectAppPoliciesItem(_ item: AppPoliciesItem)
}

class AppPoliciesTableView: UITableView {
    
    weak var appPoliciesDelegate: AppPoliciesTableViewDelegate?
    
    private let items = AppPoliciesItem.allCases
    
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

extension AppPoliciesTableView: UITableViewDataSource, UITableViewDelegate {
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        HapticsManager.shared.selectionVibrate()
        
        // Notify VC via delegate or closure if needed
        let item = items[indexPath.row]
        appPoliciesDelegate?.didSelectAppPoliciesItem(item)
    }
}
