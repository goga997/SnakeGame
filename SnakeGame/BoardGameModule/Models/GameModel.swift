//
//  SnakeBoard.swift
//  SnakeGame
//
//  Created by Grigore on 05.12.2023.
//

import Foundation

protocol ProgressViewProtocol: AnyObject {
    func setProgress(result: Int)
}

class GameModel {
    
    private var gameDetails: GameDetails
    private var score: Score
    private var snake = Snake()
    private var addPoint = AddPoint()
    
    let gameTimer = GameTimer()
    let customAlert = CustomAlert()
    
    var isGameOver: Bool = false
    
    private weak var viewController: MainViewController?
    
    //MARK: - Initialization + funcs
    init(vc: MainViewController, gameDetails: GameDetails) {
        self.gameDetails = gameDetails
        self.score = Score(next: gameDetails.toNextLevel)
        viewController = vc
        gameTimer.timerDelegate = self
        gameTimer.startTimer()
        vc.updateAddPoint(addPoint.coordinate)
    }
    
    // Game Ation Functionality -----------------
    func changeDirection(_ direction: MovingDirection) {
        snake.checkDirection(direction)
    }
    
    private func checkEatint() {
        if snake.snake[0] == addPoint.coordinate {
            snake.eatAddPoint()
            addPoint.randomiseAddPoint(snake: snake.snake, cols: gameDetails.cols, rows: gameDetails.rows)
            HapticsManager.shared.impactFeedback(for: .soft)
            
            if score.addScore() {
                gameTimer.speedIncrease()
            }
            
            viewController?.updateScoreLabels(score: score.amount, toNextLevel: score.toNextLevel)
            viewController?.updateAddPoint(addPoint.coordinate)
            viewController?.updateProgressView(result: gameDetails.toNextLevel)
        }
    }
    
    //Method that is checking if the snake is on board and the second method to check what button to show (play/pause)
    func isOnBoard() {
        if snake.snake[0].row < 0 || snake.snake[0].row > gameDetails.rows - 1 ||
            snake.snake[0].col < 0 || snake.snake[0].col > gameDetails.cols - 1 {
            HapticsManager.shared.vibrate(for: .warning)
            gameTimer.stopTimer()
            trigger()
        }
    }
    
    func trigger() {
        viewController?.hideAndShowProgressView()
        customAlert.updateScoreLabels(score: score.amount, toNextLevel: score.toNextLevel)
        customAlert.presentCustomAlert(viewController: viewController!) { [weak self] in
            guard let self = self else {return}
            viewController?.startNewGame()
            viewController?.updateProgressView(result: gameDetails.toNextLevel)
            viewController?.hideAndShowProgressView()
        }
    }
}

//MARK: Timer Protocol     ----    Every (seond (depending) ) something is happening
extension GameModel: TimerProtocol {
    func timerAction() {
        snake.moveSnake()
        
        checkEatint()
        isOnBoard()
        
        if snake.crashTest() {
            HapticsManager.shared.vibrate(for: .error)
            gameTimer.stopTimer()
            trigger()
        }
        
        viewController?.updateSnake(snake.snake )
    }
}

