//
//  SettingsCell.swift
//  SnakeGame
//
//  Created by Grigore on 21.05.2025.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    static let reuseID = "SettingsCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.tintColor = #colorLiteral(red: 0.2, green: 0.5529411765, blue: 0.4941176471, alpha: 1)
        imageView.tintColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        //view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9647058824, alpha: 1)
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = .clear
            selectionStyle = .default
            contentView.addSubview(containerView)
            containerView.addSubview(iconImageView)
            containerView.addSubview(titleLabel)
            containerView.addSubview(arrowImageView)

            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

                iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
                iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                iconImageView.widthAnchor.constraint(equalToConstant: 20),
                iconImageView.heightAnchor.constraint(equalToConstant: 20),

                titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
                titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

                arrowImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
                arrowImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                arrowImageView.widthAnchor.constraint(equalToConstant: 12),
                arrowImageView.heightAnchor.constraint(equalToConstant: 18)
            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    // MARK: - Public Configure
        func configure(with title: String, icon: UIImage?) {
            titleLabel.text = title
            iconImageView.image = icon
        }
}

