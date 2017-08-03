//
//  GeneralExtensions.swift
//  PinterestTexture
//
//  Created by Hellen Soloviy on 8/3/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

extension Integer {
    var boolValue: Bool {
        if self == 0 {
            return false
        } else {
            return true
        }
    }
}

//extension ASNetworkImageNode {
//    
//    func round(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        
//        DispatchQueue.main.async {
//            self.layer.mask = mask
//
//        }
//    }
//    
//}
//extension UIImage {
//    
//    func round(cornerRadius: CGFloat) -> UIImage {
//        
//        let frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
//        
//        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
//        
//        let path = UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius)
//        path.addClip()
//
//        self.draw(in: frame)
//        
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return newImage!
//    }
//    
//}
