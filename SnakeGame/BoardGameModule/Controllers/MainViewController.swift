//
//  ViewController.swift
//  SnakeGame
//
//  Created by Grigore on 05.12.2023.
//

import UIKit

class MainViewController: UIViewController {
            
    private var gameModel: GameModel?
    private let gameDetails: GameDetails
    
    private var mainView: MainView {
        view as! MainView
    }
        
    //MARK: - LIFE CYCLE 
    override func loadView() {
        self.view = MainView(gameDetails: gameDetails)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.boardDelegate = self
        mainView.updateScoreLabels(score: 0, toNextLevel: gameDetails.toNextLevel)
        mainView.setProgress(gameDetails.toNextLevel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateHeartsLabel), name: HeartManager.heartsUpdatedNotification, object: nil)
    }
    
    init(gameDetails: GameDetails) {
        self.gameDetails = gameDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateHeartsLabel() {
        mainView.heartsLabel.text = "\(HeartManager.hearts)"
    }

// Updating Functions
    func updateSnake(_ snake: [GameCell]) {
        let boardView = mainView.subviews[0] as? BoardView
        boardView?.snake = snake
    }
    
    func updateAddPoint(_ addPoint: GameCell) {
        let boardView = mainView.subviews[0] as? BoardView
        boardView?.addPoint = CGPoint(x: addPoint.col, y: addPoint.row)
    }
    
    func updateScoreLabels(score: Int, toNextLevel: Int) {
        mainView.updateScoreLabels(score: score, toNextLevel: toNextLevel)
    }
    
    func updateProgressView(result: Int) {
        mainView.setProgress(gameDetails.toNextLevel)
    }
    
    func hideAndShowProgressView() {
        if mainView.toNextLevelLabel.isHidden == false {
            mainView.removeProgressView()
        } else {
            mainView.addProgressView()
        }
    }

    @objc func playButtonTapped() {   //Play Button + Pause Button
        if gameModel == nil || gameModel?.isGameOver == true {
            guard HeartManager.hearts > 0 else {
                    showNoHeartsAlert()
                    return
                }
                HeartManager.hearts -= 1
            
            gameModel = GameModel(vc: self, gameDetails: gameDetails)
            gameModel?.isGameOver = false
        } else {
            gameModel?.gameTimer.startTimer()
        }
        
        mainView.playButton.isHidden = true
        mainView.pauseButton.isHidden = false
    }
    
    @objc func pauseButtonTapped() {
        gameModel?.gameTimer.stopTimer()
        mainView.pauseButton.isHidden = true
        mainView.playButton.isHidden = false
    }
    
    @objc func backToOptionsButtonTapped() {
        HapticsManager.shared.vibrate(for: .success)
        dismiss(animated: true)
    }
    
    func startNewGame() {
        updateSnake([GameCell(col: 1, row: 0),
                    GameCell(col: 0, row: 0)])

        gameModel = GameModel(vc: self, gameDetails: gameDetails)
        
        gameModel?.gameTimer.stopTimer()
        mainView.updateScoreLabels(score: 0, toNextLevel: gameDetails.toNextLevel)
        
        mainView.playButton.isHidden = false
        mainView.pauseButton.isHidden = true
        gameModel?.isGameOver = true

    }
    
    private func showNoHeartsAlert() {
        let alert = UIAlertController(
            title: "alert_no_hearts_title".localized,
            message: "alert_no_hearts_message".localized,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            //send a notification to the SetUpVC in order to open custom pop-up view for ads watching
            self.dismiss(animated: true)
            //wait a bit and then send notification
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                NotificationCenter.default.post(name: Notification.Name("showAdPopUpAfterDismiss"), object: nil)
            }
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}

//BoardViewProtocol
extension MainViewController: BoardProtocol {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .left: gameModel?.changeDirection(.left)
        case .right: gameModel?.changeDirection(.right)
        case .up: gameModel?.changeDirection(.up)
        case .down: gameModel?.changeDirection(.down)
        default:
            break
        }
    }
}
