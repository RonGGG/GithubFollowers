//
//  UserInfoVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 24/1/2024.
//

import UIKit

protocol UserInforVCDelegate {
    func didClickActionButton (sender: UIButton)
}

class UserInfoVC: UIViewController {
    
    var username : String!
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        layoutUI()
        getUserInfo()
    }
    
    private func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: self.username) {[weak self] result in
            
            guard let self = self else { return }
            
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    
                    let repoItemVC = GFRepoItemVC(user: user)
                    repoItemVC.userInfoDelegate = self
                    self.addChildVC(childVC: repoItemVC, to: self.itemView1)
                    
                    let followerItemVC = GFFollowerItemVC(user: user)
                    followerItemVC.userInfoDelegate = self
                    self.addChildVC(childVC: followerItemVC, to: self.itemView2)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Request error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc private func dismissVC(){
        dismiss(animated: true)
    }
    
    private func layoutUI() {
        
        view.addSubview(headerView)
        view.addSubview(itemView1)
        view.addSubview(itemView2)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemView1.translatesAutoresizingMaskIntoConstraints = false
        itemView2.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemView1.heightAnchor.constraint(equalToConstant: 160),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemView2.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    private func addChildVC(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension UserInfoVC: UserInforVCDelegate {
    func didClickActionButton(sender: UIButton) {
//        print("clicked\(sender.tag)")
        switch sender.tag {
        case 0:
            break
        case 1:
            break
        default:
            break
        }
    }
    
}
