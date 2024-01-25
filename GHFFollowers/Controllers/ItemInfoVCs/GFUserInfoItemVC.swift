//
//  GFUserInfoItemVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 24/1/2024.
//

import UIKit

class GFUserInfoItemVC: UIViewController {

    let stackView = UIStackView()
    let itemView1 = GFItemInfoView(frame: .zero)
    let itemView2 = GFItemInfoView(frame: .zero)
    let button = GFButton(background: .systemPurple, title: "")
        
    var userInfoDelegate : UserInforVCDelegate?
    
    let user : User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutUI()
//        configureUIElements()
        
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
    }
    
    @objc private func pressedButton () {
        guard let userInfoDelegateSafe = userInfoDelegate else { return }
        
        userInfoDelegateSafe.didClickActionButton(sender: button)
    }
    
    private func layoutUI(){
        view.addSubview(stackView)
        view.addSubview(button)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemView1)
        stackView.addArrangedSubview(itemView2)
//        stackView.spacing = 10 // minimum spacing
        
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),

            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8)
        ])
    }
//    private func configureUIElements(){
//        itemView1.set(itemInfo: .repos, with: user.publicRepos)
//        itemView2.set(itemInfo: .gists, with: user.publicGists)
//        button.setTitle("GitHub Profile", for: .normal)
//    }
}
