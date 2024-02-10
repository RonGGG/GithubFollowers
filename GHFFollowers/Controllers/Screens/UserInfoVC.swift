//
//  UserInfoVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 24/1/2024.
//

import UIKit

protocol UserInforVCDelegate: AnyObject {
    func didClickActionButton (sender: UIButton, user: User)
}

class UserInfoVC: UIViewController {
    
    var username : String!
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = GFTitleLabel(textAlignment: .center, font: UIFont.systemFont(ofSize: 15, weight: .regular))
    
    weak var followerListVCDelagate: FollowerListVCDelegate?
    
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
                    
                    self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
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
        view.addSubview(dateLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemView1.translatesAutoresizingMaskIntoConstraints = false
        itemView2.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.textColor = .secondaryLabel
        
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
            
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding/2),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 40)
            
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
    func didClickActionButton(sender: UIButton, user: User) {
        
//        print("clicked\(sender.tag)")
        switch sender.tag {
        case 0: // clicked GitHub Profile
            presentSafariVC(url: user.htmlUrl)
        case 1: // clicked Get Followers
            if user.followers == 0 {
                presentGFAlertOnMainThread(title: "No followers", message: "This user doesn't have followers.", buttonTitle: "OK")
                return
            }
            guard let delegateSafe = followerListVCDelagate else { return }
            delegateSafe.didRequestFollowers(username: user.login)
            
            dismissVC()
        default:
            break
        }
    }
    
}
