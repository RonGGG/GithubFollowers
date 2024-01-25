//
//  GFButton.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

class GFButton: UIButton {

    // override the designed init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        /*
         这里之所以把configure单独写一个方法是因为：
         可读性：将配置代码分离到configure()方法使得init(frame:)方法更简洁、更易于阅读。当其他开发者查看init方法时，他们可以快速理解这个初始化器的目的是调用配置方法，而不是深入细节。

         复用性：如果在类中有多个初始化器，或者未来可能添加更多的初始化器，那么configure()方法可以被所有的初始化器复用，而不是在每个初始化器中重复相同的配置代码。

         维护性：如果配置需要变更，你只需在configure()方法中修改，而不是在多个地方寻找并更新配置代码。这降低了出错的机会，也使得维护成本更低。

         扩展性：在未来，如果GFButton类的配置变得更加复杂，包含了更多的属性设置或初始化代码，configure()方法提供了一个集中管理这些配置的地方。

         重载：在子类中，如果你想要扩展或修改按钮的配置，只需要重载configure()方法，而不是重载每个init方法。
         */
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // initialize with background and title for UIButton
    init(background: UIColor, title: String) {
        
        super.init(frame: .zero)
        self.backgroundColor = background
        self.setTitle(title, for: .normal)
        
        configure()
    }
    
    
    // configure the UIButton view
    private func configure() {
        layer.cornerRadius = 10
//        titleLabel?.textColor = .white
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        /*
          transform from autoresizing to autolayout
         
          true: using frame, bounds, center etc;
          false: using constraints
         */
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(title: String, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
}
