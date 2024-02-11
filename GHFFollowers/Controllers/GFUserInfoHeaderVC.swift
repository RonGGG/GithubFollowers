//
//  GFUserInfoHeaderVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 24/1/2024.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageVIew = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(textAlignment: .left, font: UIFont.systemFont(ofSize: 38, weight: .bold))
    let nameLabel = GFTitleLabel(textAlignment: .left, font: UIFont.systemFont(ofSize: 18, weight: .regular))
    let locationImageView = UIImageView()
    let locationLabel = GFTitleLabel(textAlignment: .left, font: UIFont.systemFont(ofSize: 18, weight: .regular))
    
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    let user : User!
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        layoutUI()
        configureUIElements()
    }
    
    private func addSubViews() {
        view.addSubview(avatarImageVIew)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    private func layoutUI(){
        
        nameLabel.textColor = .secondaryLabel
        locationLabel.textColor = .secondaryLabel
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let insidePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageVIew.heightAnchor.constraint(equalToConstant: 90),
            avatarImageVIew.widthAnchor.constraint(equalToConstant: 90),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImageVIew.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageVIew.trailingAnchor, constant: insidePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageVIew.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageVIew.trailingAnchor, constant: insidePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageVIew.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageVIew.trailingAnchor, constant: insidePadding),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageVIew.bottomAnchor, constant: 8),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageVIew.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureUIElements() {
        avatarImageVIew.loadImage(from: user.avatarUrl)
        userNameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationImageView.image = SFSymbols.location
        locationLabel.text = user.location ?? ""
        bioLabel.text = user.bio ?? "Nothing"
        bioLabel.numberOfLines = 4
    }
}
