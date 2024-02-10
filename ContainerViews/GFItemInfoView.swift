//
//  GFItemInfoView.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 24/1/2024.
//

import UIKit

enum ItemInfoType {
    case repos,gists, followers, following
}
class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .center, font: UIFont.systemFont(ofSize: 14, weight: .bold))
    let countLabel = GFTitleLabel(textAlignment: .center, font: UIFont.systemFont(ofSize: 14, weight: .bold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
                
        let padding:CGFloat = 10
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 8),
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
    }
    func set(itemInfo: ItemInfoType, with count: Int) {
        
        countLabel.text = String(count)
        
        switch itemInfo {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
    }
}
