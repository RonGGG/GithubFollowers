//
//  GFAvatarImageView.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 19/1/2024.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholderImg = UIImage(named: "avatar-placeholder")
    
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
        clipsToBounds = true // 裁切图片多余的部分
        image = placeholderImg
    }
    
    func loadImage(from avatarUrlString: String){
        NetworkManager.shared.downloadImage(from: avatarUrlString) {[weak self] imgData in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: imgData)
            }
        }
    }
}
