//
//  UserInfoVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 24/1/2024.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let avatarImgView = GFAvatarImageView(frame: .zero)
    let loginLabel = GFTitleLabel(textAlignment: .left, font: UIFont.systemFont(ofSize: 28, weight: .bold))
    let nameLabel = GFBodyLabel(textAlignment: .left)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var username : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        NetworkManager.shared.getUserInfo(for: self.username) {[weak self] result in
            
            guard let self = self else { return }
            
            switch result{
            case .success(let user):
                print(user.login, user.name ?? "")
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Request error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
}
