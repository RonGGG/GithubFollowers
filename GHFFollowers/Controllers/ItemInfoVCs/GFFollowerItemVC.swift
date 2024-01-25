//
//  GFFollowerItemVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 26/1/2024.
//

import UIKit

class GFFollowerItemVC: GFUserInfoItemVC {
    
    override init(user: User) {
        super.init(user: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.tag = 1
        customizeUI()
    }
    
    private func customizeUI() {
        itemView1.set(itemInfo: .followers, with: user.followers)
        itemView2.set(itemInfo: .following, with: user.following)
        button.set(title: "Get Followers", backgroundColor: .systemGreen)
    }
}
