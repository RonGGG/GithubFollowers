//
//  UIHelper.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 22/1/2024.
//

import UIKit

enum UIHelper {
    static func createThreeColumnFlowLayout(for view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpacing:CGFloat = 10
        let itemWidth:CGFloat = (width - (padding * 2) - (minimumItemSpacing * 2))/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth+35)
        
        return flowLayout
    }
}
