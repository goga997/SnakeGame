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
    
    override func loadView() {
        self.view = MainSetupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackImage()
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
            print("Erron level Button")
        }
        
        let mainVC = MainViewController(gameDetails: gameDetails)
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .flipHorizontal
        HapticsManager.shared.vibrate(for: .success)
        present(mainVC, animated: true)
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
            print("Erron level Button")
        case 2:
            print("Erron level Button")
        default:
            print("Erron level Button")

        }
    }
}
