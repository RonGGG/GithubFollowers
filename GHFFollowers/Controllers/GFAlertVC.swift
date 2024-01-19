//
//  GFAlertVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let alertView : GFAlertView
    
    var alertAction: (()->(Void))?
    
    init(alertTitle: String, alertMessage: String, alertButtonTitle: String) {
        
        alertView = GFAlertView(title: alertTitle, message: alertMessage, buttonTitle: alertButtonTitle)
        alertAction = {}
        super.init(nibName: nil, bundle: nil)
    }
    
    init(alertTitle: String, alertMessage: String, alertButtonTitle: String, alertAction: (()->(Void))? = nil ) {
        
        alertView = GFAlertView(title: alertTitle, message: alertMessage, buttonTitle: alertButtonTitle)
        
        self.alertAction = alertAction
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissVC() {
        
        dismiss(animated: true)
        
        if let alertActionSafe = alertAction {
            alertActionSafe()
        }
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
