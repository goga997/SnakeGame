//
//  MainView.swift
//  SnakeGame
//
//  Created by Grigore on 17.12.2023.
//

import UIKit

protocol BoardProtocol: AnyObject {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction)
}

class MainView: UIView {
    
    weak var boardDelegate: BoardProtocol?
    
    private var gameDetails: GameDetails?
    private var boardView = BoardView()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = #colorLiteral(red: 0.6700997949, green: 0.02941261418, blue: 0.1527844965, alpha: 1)
        progressView.trackTintColor = #colorLiteral(red: 0.9098039216, green: 0.7254901961, blue: 0.6666666667, alpha: 1)
        progressView.layer.cornerRadius = 15
        progressView.clipsToBounds = true
        progressView.setProgress(0, animated: true)
        progressView.layer.sublayers?[1].cornerRadius = 15
        progressView.subviews[1].clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let scoreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yourScore")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //Labels
    let scoreLabel = UILabel()
    let nextLevelNumberLabel = UILabel()
    let toNextLevelLabel = UILabel(text: "Points remained to next Level !!")
    
    private let fadingLabel: UILabel = {
        let fadingLabel = UILabel()
        fadingLabel.text = "Speed Increased"
        fadingLabel.isHidden = true
        fadingLabel.textColor = .black
        fadingLabel.font = .fingerPaintFont22()
        fadingLabel.translatesAutoresizingMaskIntoConstraints = false
        return fadingLabel
    }()
    
    private let hourglassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hourglass")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //ControlButtons
    lazy var playButton = ControlButton(image: "play")
    lazy var pauseButton = ControlButton(image: "pause")
    lazy var backToOptionsButton = ControlButton(image: "arrowshape.turn.up.backward")
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(gameDetails: GameDetails) {
        self.init()
        self.gameDetails = gameDetails
        self.boardView = BoardView(cols: gameDetails.cols, rows: gameDetails.rows)
        
        addSwipe()
        
        backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9411764706, blue: 0.9254901961, alpha: 1)
        configureBoardView()
        
        configFadingLabelAndHourglass()
        configureScoreImageView()
        configureScoreLabel()
        configurePlayButton()
        configurePauseButton()
        configureBackToOptionsButton()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureProgressView()
        configureNextLevelNumberLabel()
        configureMainLabelToNext()
    }
    
    private func configureBoardView() {
        addSubview(boardView)
        NSLayoutConstraint.activate([
            boardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            boardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    private func configFadingLabelAndHourglass() {
        addSubview(fadingLabel)
        boardView.addSubview(hourglassImageView)
        NSLayoutConstraint.activate([
            fadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            fadingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            hourglassImageView.centerYAnchor.constraint(equalTo: boardView.centerYAnchor),
            hourglassImageView.centerXAnchor.constraint(equalTo: boardView.centerXAnchor),
            hourglassImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.16),
            hourglassImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.16)
        ])
    }
    
    private func configureMainLabelToNext() {
        addSubview(toNextLevelLabel)
        NSLayoutConstraint.activate([
            toNextLevelLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -10),
            toNextLevelLabel.leadingAnchor.constraint(equalTo: nextLevelNumberLabel.trailingAnchor, constant: 10),
        ])
    }
    
    private func configureProgressView() {
        addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -20),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            progressView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
        ])
    }
    
    private func configureNextLevelNumberLabel() {
        nextLevelNumberLabel.textColor = .black
        nextLevelNumberLabel.font = .fingerPaintFont28()
        nextLevelNumberLabel.textAlignment = .center
        nextLevelNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nextLevelNumberLabel)
        NSLayoutConstraint.activate([
            nextLevelNumberLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -5 ),
            nextLevelNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
        ])
    }
    
    private func configureScoreImageView() {
        addSubview(scoreImageView)
        NSLayoutConstraint.activate([
            scoreImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            scoreImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            scoreImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
        ])
    }
    
    private func configureScoreLabel() {
        scoreLabel.font = .fingerPaintFont42()
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = .black
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreImageView.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.bottomAnchor.constraint(equalTo: scoreImageView.bottomAnchor, constant: -12),
            scoreLabel.trailingAnchor.constraint(equalTo: scoreImageView.trailingAnchor, constant: -45)
        ])
    }
    
    private func configurePlayButton() {
        playButton.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.7647058824, blue: 0.6745098039, alpha: 1)
        playButton.addTarget(nil, action: #selector(MainViewController.playButtonTapped), for: .touchUpInside)
        addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 25 ),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            playButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            playButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
        ])
    }
    
    private func configurePauseButton() {
        pauseButton.isHidden = true
        pauseButton.addTarget(nil, action: #selector(MainViewController.pauseButtonTapped), for: .touchUpInside)
        addSubview(pauseButton)
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 25 ),
            pauseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            pauseButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            pauseButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
        ])
    }
    
    private func configureBackToOptionsButton() {
        backToOptionsButton.addTarget(nil, action: #selector(MainViewController.backToOptionsButtonTapped), for: .touchUpInside)
        addSubview(backToOptionsButton)
        NSLayoutConstraint.activate([
            backToOptionsButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 25 ),
            backToOptionsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            backToOptionsButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            backToOptionsButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
        ])
    }
    
    func updateScoreLabels(score: Int, toNextLevel: Int) {
        scoreLabel.text = "\(score)"
        nextLevelNumberLabel.text = "\(toNextLevel)"
    }
    
    func setProgress(_ result: Int) {
        let percentResult = (Float(nextLevelNumberLabel.text ?? "") ?? 0.0) / Float(result)
        progressView.setProgress(percentResult, animated: true)
        if String(result) == nextLevelNumberLabel.text {
            fadeMessage(finalAlpha: 0.0)
        }
    }
    
    func fadeMessage(finalAlpha: CGFloat) {
        fadingLabel.alpha         = 1.0
        fadingLabel.isHidden      = false
        fadingLabel.textAlignment = .center
        fadingLabel.layer.masksToBounds = true
        
        hourglassImageView.alpha = 1.0
        hourglassImageView.isHidden = false
        hourglassImageView.layer.masksToBounds = true
        
        UIView.animate(withDuration: 3.0, animations: { () -> Void in
            self.fadingLabel.alpha = finalAlpha
            self.hourglassImageView.alpha = finalAlpha
        })
    }
    
    func removeProgressView() {
        progressView.isHidden = true
        nextLevelNumberLabel.isHidden = true
        toNextLevelLabel.isHidden = true
    }
    
    func addProgressView() {
        progressView.isHidden = false
        nextLevelNumberLabel.isHidden = false
        toNextLevelLabel.isHidden = false
    }
}

//MARK: - UISwipeGestures

extension MainView {
    
    private func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .down, .right, .up]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            swipe.direction = $0
            addGestureRecognizer(swipe)
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        let location = sender.location(in: self)
        if boardView.frame.contains(location) {
            boardDelegate?.swipeGesture(direction: sender.direction)
        }
    }
}

