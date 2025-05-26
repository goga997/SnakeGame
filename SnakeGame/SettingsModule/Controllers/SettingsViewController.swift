//
//  SettingsViewController.swift
//  SnakeGame
//
//  Created by Grigore on 18.05.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
    
    private lazy var notificationsToggle: LabeledSwitchView = {
        let savedState = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        let toggle = LabeledSwitchView(title: "Notifications", isOn: savedState) { isOn in
            if isOn {
                NotificationManager.shared.isAuthorized { authorized in
                    DispatchQueue.main.async {
                        if authorized {
                            UserDefaults.standard.set(true, forKey: "notificationsEnabled")
                            NotificationManager.shared.scheduleThreeDailyPremiumReminders()
                            NotificationManager.shared.sendHeartsRestoredNotification()
                        } else {
                            self.notificationsToggle.setSwitchState(isOn: false)
                            UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                            self.showPermissionAlert()
                        }
                    }
                }
            } else {
                UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                NotificationManager.shared.cancelAllNotifications()
            }
        }
        return toggle
    }()
    
    private let hapticToggle = LabeledSwitchView(
        title: "Haptic",
        isOn: UserDefaults.standard.bool(forKey: "hapticsEnabled") //read saved state
    ) { isOn in
        print("Haptic switched to \(isOn)")
        UserDefaults.standard.set(isOn, forKey: "hapticsEnabled") //save new state
    }
    
    private let appPoliciesTableView = AppPoliciesTableView()
    
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        applyLaunchGradient(to: view)
        setUpView()
        setConstraints()
        
        NotificationManager.shared.isAuthorized { [weak self] authorized in
            DispatchQueue.main.async {
                if !authorized {
                    self?.notificationsToggle.setSwitchState(isOn: false)
                }
            }
        }

    }
    
    private func isNotificationToggleEnabled() -> Bool {
        let granted = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        return granted
    }

    private func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Enable Notifications",
            message: "To receive reminders and alerts, please enable notifications in Settings.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }))
        present(alert, animated: true)
    }

    
    private func setUpView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(closeButton)
        
        premiumBannerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(premiumBannerView)
        
        settingsTableView.settingsDelegate = self
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.layer.cornerRadius = 20
        settingsTableView.clipsToBounds = true
        contentView.addSubview(settingsTableView)
        
        notificationsToggle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(notificationsToggle)
        
        hapticToggle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hapticToggle)
        
        appPoliciesTableView.appPoliciesDelegate = self
        appPoliciesTableView.translatesAutoresizingMaskIntoConstraints = false
        appPoliciesTableView.layer.cornerRadius = 20
        appPoliciesTableView.clipsToBounds = true
        contentView.addSubview(appPoliciesTableView)
    }
    
    @objc private func closeTapped() {
        HapticsManager.shared.impactFeedback(for: .soft)
        dismiss(animated: true)
    }
}


//Delegate for settingsItem
extension SettingsViewController: SettingsTableViewDelegate {
    func didSelectSettingsItem(_ item: SettingsItem) {
        switch item {
        case .language:
            print("language")
        case .buyHearts:
            print("Tapped: Buy Hearts")
        case .resetOnboarding:
            print("Tapped: Reset Onboarding")
        case .followOnSocials:
            print("Tapped: Follow on Socials")
        case .appStoreReview:
            print("Tapped: AppStore Review")
        }
    }
}

//Delegate for AppPoliciesItem
extension SettingsViewController: AppPoliciesTableViewDelegate {
    func didSelectAppPoliciesItem(_ item: AppPoliciesItem) {
        switch item {
        case .termsOfUse:
            print("terms use")
        case .privacy:
            print("privacy")
        case .legalNotice:
            print("legal notice")
        }
    }
}


// For UI implementation
extension SettingsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //  contentView fill scrollView and has the same width
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Title + Close btn
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            
            //  Premium Banner
            premiumBannerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            premiumBannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            premiumBannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            premiumBannerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.09), // flexible
            
            //  Settings Table
            settingsTableView.topAnchor.constraint(equalTo: premiumBannerView.bottomAnchor, constant: 16),
            settingsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            settingsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            settingsTableView.heightAnchor.constraint(equalToConstant: 249),
            
            //  Notifications Toggle
            notificationsToggle.topAnchor.constraint(equalTo: settingsTableView.bottomAnchor, constant: 16),
            notificationsToggle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notificationsToggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            //  Haptic Toggle
            hapticToggle.topAnchor.constraint(equalTo: notificationsToggle.bottomAnchor, constant: 16),
            hapticToggle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hapticToggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            //  App Policies Table
            appPoliciesTableView.topAnchor.constraint(equalTo: hapticToggle.bottomAnchor, constant: 16),
            appPoliciesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            appPoliciesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            appPoliciesTableView.heightAnchor.constraint(equalToConstant: 149),
        ])
    }

}
