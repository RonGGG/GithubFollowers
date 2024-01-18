//
//  GFTextField.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor // layer.borderColor是CGColor类型，因此不能直接.systemGrey4
        
        textColor = .label // 标准UILable的color，并能根据Light/Dark Mode进行自动变色
        tintColor = .label // 光标cursor的颜色
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        adjustsFontSizeToFitWidth = true
        // 当输入很多字符时，自动调节font大小以显示全部字符，但不能太小，因此需要下面的minimum来约束最小的FontSize
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground // 动态颜色设置，因为是UITextField，因此需要用动态颜色中最顶层UI的颜色
        autocorrectionType = .no // 不自动修正username
        
//        keyboardType = .emailAddress // 键盘类型
        returnKeyType = .go // return键类型
        
        placeholder = "Enter a username"
    }
    
}
