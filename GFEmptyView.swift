//
//  GFEmptyView.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 22/1/2024.
//

import UIKit

class GFEmptyView: UIView {

    let logoImageView = UIImageView()
    let messagelabel = GFTitleLabel(textAlignment: .center, font: UIFont.systemFont(ofSize: 28, weight: .bold))
    let padding: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messagelabel.text = message
        configure()
    }
    
    func configure() {
        
        backgroundColor = .systemBackground
        addSubview(messagelabel)
        addSubview(logoImageView)
        
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
//        messagelabel.text = "This user doesn't have any followers."
        messagelabel.textColor = .secondaryLabel
        messagelabel.numberOfLines = 3
        

        NSLayoutConstraint.activate([
            messagelabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messagelabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            messagelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 200),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
        ])
    }
}
