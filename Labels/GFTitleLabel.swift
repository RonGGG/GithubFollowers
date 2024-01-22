//
//  GHTitleLabel.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, font: UIFont) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = font
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail // 尾部省略
    }
}
