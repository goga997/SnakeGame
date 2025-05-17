//
//  PopUpView.swift
//  SnakeGame
//
//  Created by Grigore on 21.12.2024.
//

import UIKit
import GoogleMobileAds

class PopUpView: UIView {
    
    private let remainingScansLabel: UILabel = {
        let label = UILabel()
        label.text = "Remaining games"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scansCountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(HeartManager.hearts)"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconHeart1 = UIComponents.createHeartImageView()
    private let iconHeart2 = UIComponents.createHeartImageView()
    
    private let adScansLabel: UILabel = {
        let label = UILabel()
        label.text = "+1"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let perAdLabel: UILabel = {
        let label = UILabel()
        label.text = "per Ad"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewAdButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("  VIEW", for: .normal) //space for icon
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = #colorLiteral(red: 0.2, green: 0.5529411765, blue: 0.4901960784, alpha: 1)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isEnabled = false
        button.alpha = 0.5
        
        // Generate image with text "Ad"
        let iconSize = CGSize(width: 24, height: 18)
        let iconImage = createIconWithText(
            text: "Ad",
            size: iconSize,
            backgroundColor: .white,
            textColor: #colorLiteral(red: 0.2, green: 0.5529411765, blue: 0.4901960784, alpha: 1),
            cornerRadius: 4
        )
        
        
        let iconAttachment = NSTextAttachment()
        iconAttachment.image = iconImage
        iconAttachment.bounds = CGRect(x: 0, y: -2, width: iconSize.width, height: iconSize.height) // Ajustare poziție
        
        let iconString = NSAttributedString(attachment: iconAttachment)
        let textString = NSMutableAttributedString(string: "  VIEW")
        let finalString = NSMutableAttributedString(attributedString: iconString)
        finalString.append(textString)
        
        button.setAttributedTitle(finalString, for: .normal)
        button.addTarget(self, action: #selector(viewAdButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(nil, action: #selector(SetupViewController.closePopUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconHeart1.tintColor = #colorLiteral(red: 0.8078431373, green: 0.1843137255, blue: 0.1333333333, alpha: 1)
        iconHeart2.tintColor = #colorLiteral(red: 0.8078431373, green: 0.1843137255, blue: 0.1333333333, alpha: 1)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateHearts),
                                               name: HeartManager.heartsUpdatedNotification,
                                               object: nil)
        
        configure()
        setConstraints()
        
        //managing ads
        AdsManager.shared.delegate = self
        AdsManager.shared.loadAd()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewAdButton.isEnabled = true
            self.viewAdButton.alpha = 1.0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateHearts() {
        scansCountLabel.text = "\(HeartManager.hearts)"
    }
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.7803921569, blue: 0.7019607843, alpha: 1)
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        
        addSubview(closeButton)
        
        addSubview(remainingScansLabel)
        addSubview(scansCountLabel)
        addSubview(iconHeart1)
        addSubview(adScansLabel)
        addSubview(iconHeart2)
        addSubview(perAdLabel)
        addSubview(viewAdButton)
        
    }
    
    private func createIconWithText(text: String, size: CGSize, backgroundColor: UIColor, textColor: UIColor, cornerRadius: CGFloat = 6) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let roundedRect = CGRect(origin: .zero, size: size)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        context.addPath(path.cgPath)
        context.clip()
        
        context.setFillColor(backgroundColor.cgColor)
        context.fill(roundedRect)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10, weight: .bold),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        let textRect = CGRect(x: 0, y: (size.height - 12) / 2, width: size.width, height: 12)
        text.draw(in: textRect, withAttributes: attributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            remainingScansLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -15),
            remainingScansLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            scansCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 16),
            scansCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            iconHeart1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 15),
            iconHeart1.leadingAnchor.constraint(equalTo: scansCountLabel.trailingAnchor, constant: 3),
            iconHeart1.heightAnchor.constraint(equalToConstant: 32),
            iconHeart1.widthAnchor.constraint(equalToConstant: 32),
            
            adScansLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -25),
            adScansLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -85),
            
            iconHeart2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -25),
            iconHeart2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            
            perAdLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5),
            perAdLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            
            viewAdButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 25),
            viewAdButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            viewAdButton.widthAnchor.constraint(equalToConstant: 92),
            viewAdButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc private func viewAdButtonTapped() {
        AdsManager.shared.showAd()
    }
    
}

// MARK: - GADFullScreenContentDelegate
//for managing ads
extension PopUpView: FullScreenContentDelegate {
    
    func adDidDismissFullScreenContent() {
        print("Ad was dismissed, loading new ad...")
        // Verifică că ad-ul este complet închis înainte de a încărca unul nou
        AdsManager.shared.loadAd()
    }
    
    func adDidFailToPresentFullScreenContent(_ ad: FullScreenPresentingAd, error: Error) {
        print("Failed to present ad: \(error.localizedDescription)")
        AdsManager.shared.loadAd()
    }
}
