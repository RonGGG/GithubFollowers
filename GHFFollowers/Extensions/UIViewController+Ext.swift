//
//  UIViewController+Ext.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 18/1/2024.
//

import UIKit
/*
 这里是extension的第二种用途：
 当想扩充某一个系统自定义类的类方法的时候可以用extension
 
 这里扩充了UIViewController类，这样所有UIViewController类以及其子类都可以调用presentGFAlertOnMainThread()
 */
extension UIViewController {
    // 这里之所以用mainThread是因为当有网络操作时，每次present都需要让alert在mainThread上执行，因此不如在这里直接写好
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, alertMessage: message, alertButtonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
