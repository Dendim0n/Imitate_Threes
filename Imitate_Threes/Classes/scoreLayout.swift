//
//  scoreLayout.swift
//  Imitate_Threes
//
//  Created by 任岐鸣 on 2016/10/14.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class scoreLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var lastRect:CGRect = CGRect.zero
        lastRect.origin = proposedContentOffset
        lastRect.size = (self.collectionView?.frame.size)!
        
        let array = layoutAttributesForElements(in: lastRect)
        let centerX = proposedContentOffset.x + self.collectionView!.frame.size.width / 2
        
        var adjustOffsetX = CGFloat(MAXFLOAT)
        
        for attrs in array! {
            if(fabs(attrs.center.x - centerX) < fabs(adjustOffsetX)){
                adjustOffsetX = attrs.center.x - centerX
            }
            break
        }
        return CGPoint.init(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
    }
}
