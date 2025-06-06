//
//  SetupViewController.swift
//  SnakeGame
//
//  Created by Grigore on 18.12.2023.
//

import UIKit
import UserNotifications

class SetupViewController: UIViewController {
    
    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    private var mainSetUpView: MainSetupView? {
        view as? MainSetupView
    }
    
    private lazy var popUpView = PopUpView()
    private var giftButton: UIButton?
    
    override func loadView() {
        self.view = MainSetupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackImage()
        HeartManager.checkResetIfNeeded() //call it only once per loading app
        mainSetUpView?.heartsLabel.text = "\(HeartManager.hearts)"
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateHeartsLabel),
                                               name: HeartManager.heartsUpdatedNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showPopUpButtonTapped),
                                               name: Notification.Name("showAdPopUpAfterDismiss"),
                                               object: nil)
        
        // Notification Permission Request (once)
        NotificationManager.shared.requestAuthorizationIfNeeded { granted in

            let alreadySet = UserDefaults.standard.object(forKey: "notificationsEnabled") != nil

            // Dacă utilizatorul NU a setat deja toggle-ul în Settings, salvăm valoarea implicită în funcție de permisiunea acordată.
            if !alreadySet {
                UserDefaults.standard.set(granted, forKey: "notificationsEnabled")
            }

            // Planificăm notificările doar dacă avem permisiune și toggle-ul este ON
            if granted && UserDefaults.standard.bool(forKey: "notificationsEnabled") {
                NotificationManager.shared.scheduleThreeDailyPremiumReminders()
                NotificationManager.shared.sendHeartsRestoredNotification()
            }
        }

    }
    
    @objc func updateHeartsLabel() {
        mainSetUpView?.heartsLabel.text = "\(HeartManager.hearts)"
    }
    
    private func configureBackImage() {
        backgroundImage.image = UIImage(named: "newGameScreen")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    @objc func levelButtonTapped(sender: UIButton) {
        
        let isPremium = false
        
        if sender.tag != 0 && !isPremium {
            let premiumVC = MainPremiumController()
            premiumVC.modalPresentationStyle = .fullScreen
            HapticsManager.shared.impactFeedback(for: .soft)
            present(premiumVC, animated: true)
            return
        }
        
        var gameDetails = GameDetails(cols: 0, rows: 0, toNextLevel: 0)
        
        switch sender.tag {
        case 0: //veryEasyButton
            gameDetails = GameDetails(cols: 14, rows: 20, toNextLevel: 10)
        case 1: //easyButton
            gameDetails = GameDetails(cols: 12, rows: 18, toNextLevel: 9)
        case 2: //mediumButton
            gameDetails = GameDetails(cols: 10, rows: 14, toNextLevel: 8)
        case 3: //hardButton
            gameDetails = GameDetails(cols: 8, rows: 10, toNextLevel: 6)
        case 4: //veryHardButton
            gameDetails = GameDetails(cols: 8, rows: 8, toNextLevel: 4)
        default:
            print("Error level Button")
        }
        
        let mainVC = MainViewController(gameDetails: gameDetails)
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .flipHorizontal
        HapticsManager.shared.vibrate(for: .success)
        present(mainVC, animated: true)
        
    }
    
    func showAlertNoHearts() {
        let alert = UIAlertController(title: "No Hearts", message: "You have no hearts left. Watch an ad or buy more!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    @objc func settingButtonTapped(sender: UIButton) {
        switch sender.tag {
        case 0:
            HapticsManager.shared.impactFeedback(for: .rigid)
            if SnakeColor.grid == UIColor.clear {
                SnakeColor.grid = UIColor.init(_colorLiteralRed: 0.9882352941,
                                               green: 0.9411764706,
                                               blue: 0.9254901961,
                                               alpha: 1)
                sender.setImage(UIImage(systemName: "grid"), for: .normal)
            } else {
                SnakeColor.grid = UIColor.clear
                sender.setImage(UIImage(systemName: "minus"), for: .normal)
                showChangeGridLabel()
            }
        case 1:
            giftButton = sender
            showPopUpButtonTapped()
        case 2:
            let settingsVC = SettingsViewController()
            let settingsNavController = UINavigationController(rootViewController: settingsVC)
            settingsNavController.modalPresentationStyle = .fullScreen
            settingsNavController.modalTransitionStyle = .coverVertical
            HapticsManager.shared.impactFeedback(for: .soft)
            present(settingsNavController, animated: true)
        default:
            print("default")
        }
    }
    
    
    @objc private func showPopUpButtonTapped() {
        popUpView.frame.size = CGSize(width: 320, height: 110)
        popUpView.center = view.center
        
        popUpView.center.y += 120
        view.addSubview(popUpView)
        
        popUpView.transform = CGAffineTransform(scaleX: 0.8, y: 1.5)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0) {
            self.popUpView.transform = CGAffineTransform.identity
        }
        
        giftButton?.isEnabled = false
        giftButton?.layer.opacity = 0.5
    }
    
    
    @objc func closePopUp() {
        popUpView.removeFromSuperview()
        
        giftButton?.isEnabled = true
        giftButton?.layer.opacity = 1
    }
    
    private func showChangeGridLabel() {
        let label = UILabel()
        label.text = "grid_changed".localized
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
}
