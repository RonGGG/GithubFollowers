//
//  FollowerListVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

class FollowerListVC: UIViewController {

    var username : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result{
                case .success(let follower):
                    print(follower.count)
                    print(follower)
                case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Request error", message: error.rawValue, buttonTitle: "OK") {
                            self.navigationController?.popViewController(animated: true)
                        }
            }
//            guard let followersSafe = followers else {
//                self.presentGFAlertOnMainThread(title: "Request error", message: errorMessage!, buttonTitle: "OK") {
//                    self.navigationController?.popViewController(animated: true)
//                }
//                return
//            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
