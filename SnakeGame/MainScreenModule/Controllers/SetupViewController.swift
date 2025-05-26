//
//  SetupViewController.swift
//  SnakeGame
//
//  Created by Grigore on 18.12.2023.
//

import UIKit

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
        
        //NOTIFICATIONS
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateHeartsLabel),
                                               name: HeartManager.heartsUpdatedNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showPopUpButtonTapped),
                                               name: Notification.Name("showAdPopUpAfterDismiss"),
                                               object: nil)

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
}
