//
//  UIViewController+Ext.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 18/1/2024.
//

import UIKit
import SafariServices


/*
 这里是extension的第二种用途：
 当想扩充某一个系统自定义类的类方法的时候可以用extension
 
 这里扩充了UIViewController类，这样所有UIViewController类以及其子类都可以调用presentGFAlertOnMainThread()
 
 
 但注意，如果很多同父的子类都需要这些功能的话，可以考虑写一个superclass，比如：
 这里很多个ViewController要用到extension里的方法，所以可以把这里的方法放到一个自定义的GFiewController里，然后让需要的ViewController继承这个GFViewController
 */


fileprivate var loadingView: UIView!


extension UIViewController {
    // 这里之所以用mainThread是因为当有网络操作时，每次present都需要让alert在mainThread上执行，因此不如在这里直接写好
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String, actionAlert: (()->(Void))? = nil) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, alertMessage: message, alertButtonTitle: buttonTitle, alertAction: actionAlert)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentLoadingView() {
        loadingView = UIView(frame: view.bounds)
        view.addSubview(loadingView)
        
        loadingView.backgroundColor = .systemBackground
        loadingView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            loadingView.alpha = 0.8
        }
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(indicatorView)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        indicatorView.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            loadingView.removeFromSuperview()
            loadingView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emtyStateView = GFEmptyView(message: message)
        view.addSubview(emtyStateView)
        emtyStateView.frame = view.bounds
    }
    
    func presentSafariVC(url: String) {
        guard let safeUrl = URL(string: url) else { return }
        
        let safariVC = SFSafariViewController(url: safeUrl)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }

}
