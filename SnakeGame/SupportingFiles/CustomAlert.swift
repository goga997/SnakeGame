//
//  CustomAlert.swift
//  SnakeGame
//
//  Created by Grigore on 18.12.2023.
//

import UIKit


class CustomAlert {
                    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9411764706, blue: 0.9254901961, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let scrollView = UIScrollView()
    
    private var mainView: UIView?
    
    private let scoreResultView = UIView()
    private let toNextRemainedView = UIView()
    let scoreNumberLabel = UILabel(text28: "22")
    let remainedNumberLabel = UILabel(text28: "3")
    
    private var buttonAction: (() -> Void)?
    
    
    func updateScoreLabels(score: Int, toNextLevel: Int) {
        scoreNumberLabel.text = "\(score)"
        remainedNumberLabel.text = "\(toNextLevel)"
    }
    
    //Function itself
    func presentCustomAlert(viewController: UIViewController,
                            completion: @escaping () -> Void) {
        
        
        //setting grounded view
        guard let parentView = viewController.view else { return }
        mainView = parentView
        
        scrollView.frame = parentView.frame
        parentView.addSubview(scrollView)
        
        backgroundView.frame = parentView.frame
        scrollView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 40,
                                 y: -420,
                                 width: parentView.frame.width - 80,
                                 height: 420)
        scrollView.addSubview(alertView)
        
        
        //setting imageView (first)
        let gameOverImageView = UIImageView(frame: CGRect(
            x: (alertView.frame.width - alertView.frame.height * 0.7) / 2,
            y: -30,
            width: alertView.frame.height * 0.7,
            height: alertView.frame.height * 0.7))
        gameOverImageView.image = UIImage(named: "gameOver")
        gameOverImageView.contentMode = .scaleAspectFit
        alertView.addSubview(gameOverImageView)
        
        
        
        //Central Main Label
        let yourScoreLabel = UILabel(text: "Your Game Result:", font: .fingerPaintFont22(), textColor: .black)
        yourScoreLabel.frame = CGRect(x: 10,
                                    y: alertView.frame.height * 0.4 + 60,
                                    width: alertView.frame.width - 20,
                                    height: 25)
        yourScoreLabel.textAlignment = .center
        yourScoreLabel.translatesAutoresizingMaskIntoConstraints = true
        alertView.addSubview(yourScoreLabel)
        
        
        //All Labels + Views
        let scoreLabel = UILabel(text: "Score:")
        scoreLabel.textColor = .black
        scoreLabel.translatesAutoresizingMaskIntoConstraints = true
        scoreLabel.frame = CGRect(x: 40,
                                 y: yourScoreLabel.frame.maxY,
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(scoreLabel)
        
        scoreResultView.frame = CGRect(x: 30,
                                     y: scoreLabel.frame.maxY,
                                     width: alertView.frame.width - 60,
                                     height: 30)
        scoreResultView.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        scoreResultView.layer.borderWidth = 1
        scoreResultView.layer.borderColor = UIColor.gray.cgColor
        scoreResultView.layer.cornerRadius = 10
        scoreResultView.translatesAutoresizingMaskIntoConstraints = true
        alertView.addSubview(scoreResultView)

        //number itself
        scoreResultView.addSubview(scoreNumberLabel)
        NSLayoutConstraint.activate([
            scoreNumberLabel.centerXAnchor.constraint(equalTo: scoreResultView.centerXAnchor),
            scoreNumberLabel.centerYAnchor.constraint(equalTo: scoreResultView.centerYAnchor),
            scoreNumberLabel.widthAnchor.constraint(equalTo: scoreResultView.widthAnchor, multiplier: 0.5),
            scoreNumberLabel.heightAnchor.constraint(equalTo: scoreResultView.heightAnchor, multiplier: 0.9)
        ])

        
        let toNextRemainedLabel = UILabel(text: "Remained points to next level:")
        toNextRemainedLabel.textColor = .black
        toNextRemainedLabel.translatesAutoresizingMaskIntoConstraints = true
        toNextRemainedLabel.frame = CGRect(x: 40,
                                 y: scoreResultView.frame.maxY + 3,
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(toNextRemainedLabel)
        
        toNextRemainedView.frame = CGRect(x: 30,
                                     y: toNextRemainedLabel.frame.maxY,
                                     width: alertView.frame.width - 60,
                                     height: 30)
        toNextRemainedView.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        toNextRemainedView.layer.borderWidth = 1
        toNextRemainedView.layer.borderColor = UIColor.gray.cgColor
        toNextRemainedView.layer.cornerRadius = 10
        toNextRemainedView.translatesAutoresizingMaskIntoConstraints = true
        alertView.addSubview(toNextRemainedView)
        
        //number itself
        toNextRemainedView.addSubview(remainedNumberLabel)
        NSLayoutConstraint.activate([
            remainedNumberLabel.centerXAnchor.constraint(equalTo: toNextRemainedView.centerXAnchor),
            remainedNumberLabel.centerYAnchor.constraint(equalTo: toNextRemainedView.centerYAnchor),
            remainedNumberLabel.widthAnchor.constraint(equalTo: toNextRemainedView.widthAnchor, multiplier: 0.5),
            remainedNumberLabel.heightAnchor.constraint(equalTo: toNextRemainedView.heightAnchor, multiplier: 0.9)
        ])
        
        //Button of action
        let tryAgainButton = TryAgainButton(text: "Try Again")
        tryAgainButton.frame = CGRect(x: 60,
                                y: toNextRemainedView.frame.maxY + 15,
                                width: alertView.frame.width - 120,
                                height: 40)
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = true
        tryAgainButton.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        alertView.addSubview(tryAgainButton)
        
        
        buttonAction = completion
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.8
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.3) {
                    self.alertView.center = CGPoint(x: parentView.center.x, y: parentView.center.y + 20)
                }
            }
        }
    }
    
    @objc private func tryAgainButtonTapped() {
        guard let targetView = mainView else { return }
        HapticsManager.shared.selectionVibrate()
        
        
        UIView.animate(withDuration: 0.3) {
            self.alertView.frame = CGRect(x: 40,
                                          y: targetView.frame.height,
                                          width: targetView.frame.width - 80,
                                          height: 420)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.alpha = 0
            } completion: { done in
                if done {
                    self.alertView.removeFromSuperview()
                    self.backgroundView.removeFromSuperview()
                    self.scrollView.removeFromSuperview()
                                        
                    //initialization New Game / transfer function through complition
                    self.buttonAction?()
                }
            }
        }
    }
}
