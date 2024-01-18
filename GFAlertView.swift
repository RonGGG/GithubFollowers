//
//  GFAlertView.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

class GFAlertView: UIView {
    
    let titleLabel = GFTitleLabel(textAlignment: .center, font: UIFont.systemFont(ofSize: 20, weight: .bold))
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(background: .systemPink, title: "OK")
    let contentView = UIView(frame: .zero)
    let padding : CGFloat = 20

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, message: String, buttonTitle: String){
        super.init(frame: .zero)
        titleLabel.text = title
        messageLabel.text = message
        actionButton.setTitle(buttonTitle, for: .normal)
        
        configure()
    }
    
    func configureActionButton() {
        
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
        
        contentView.addSubview(messageLabel)
        
        // maximum 4 lines
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -8),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureTitleLabel() {
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])

    }
    
    func configureContentView() {
        // config contentView
        self.addSubview(contentView)
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 220),
            contentView.widthAnchor.constraint(equalToConstant: 280)
        ])
        
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    func configure() {
        
        configureContentView()
        
        // autolayout
        translatesAutoresizingMaskIntoConstraints = false
        
        // config view
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        
    }
}
