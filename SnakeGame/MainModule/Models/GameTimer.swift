//
//  GameTimerModel.swift
//  SnakeGame
//
//  Created by Grigore on 17.12.2023.
//

import Foundation

protocol TimerProtocol: AnyObject {
    func timerAction()
}

class GameTimer {
    
    weak var timerDelegate: TimerProtocol?
    
    private var timer = Timer()
    
    private var timeInterval = 0.3
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func timerAction() {
        timerDelegate?.timerAction()
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func speedIncrease() {
        if Float(timeInterval) > 0.1 {
            timeInterval -= 0.02
        }
        stopTimer()
        startTimer()
        HapticsManager.shared.vibrate(for: .success)
    }
}
