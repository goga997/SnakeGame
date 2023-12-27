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
    }
    
    init(gameDetails: GameDetails) {
        self.gameDetails = gameDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

//Play Button + Pause Button
    @objc func playButtonTapped() {
        if gameModel == nil {
            gameModel = GameModel(vc: self, gameDetails: gameDetails)
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




