//
//  GFRepoItemVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 26/1/2024.
//

import UIKit

class GFRepoItemVC: GFUserInfoItemVC {
    
    override init(user: User) {
        super.init(user: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.tag = 0
        customizeUI()
    }
    
    private func customizeUI() {
        itemView1.set(itemInfo: .repos, with: user.publicRepos)
        itemView2.set(itemInfo: .gists, with: user.publicGists)
        button.set(title: "GitHub Profile", backgroundColor: .systemPurple)
    }
}
