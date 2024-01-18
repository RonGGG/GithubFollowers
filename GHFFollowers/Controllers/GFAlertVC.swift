//
//  GFAlertVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

class GFAlertVC: UIViewController {
    
//    var alertTitle : String
//    var alertMessage : String
//    var alertButtonTitle : String
    
    let alertView : GFAlertView
    
    init(alertTitle: String, alertMessage: String, alertButtonTitle: String) {
        
//        self.alertTitle = alertTitle ?? "Title not exist"
//        self.alertMessage = alertMessage ?? "Unable to complete request"
//        self.alertButtonTitle = alertButtonTitle ?? "OK"
        
        alertView = GFAlertView(title: alertTitle, message: alertMessage, buttonTitle: alertButtonTitle)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // add alertView
        self.view.addSubview(alertView)
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alertView.topAnchor.constraint(equalTo: view.topAnchor),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // dismissVC
        alertView.actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
}
