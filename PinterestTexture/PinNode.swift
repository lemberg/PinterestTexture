//
//  PinNode.swift
//  TextureDemo
//
//  Created by Hellen Soloviy on 7/31/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import UIKit
import PinterestSDK
import AsyncDisplayKit

class PinNode: ASCellNode {
    
    var imageNode: ASNetworkImageNode = ASNetworkImageNode()
    var object: Pin
    
    init(pin: Pin) {
        self.object = pin
        
        super.init()
        
        imageNode.url = URL(string: pin.url)
        self.addSubnode(imageNode)

    }
    
//    init(with imageStringURL: String = "http://e-shuushuu.net/images/2016-08-29-856644.png") {
//        
//        super.init()
//        imageNode.url = URL(string: imageStringURL)
//        self.addSubnode(imageNode)
//        
//    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        imageNode.style.preferredSize = CGSize(width: 100, height: 200)
        
        let size = CGSize(width: object.width, height: object.height) //imageNode.calculatedSize
        print("Size - - w: \(size.width) h: \(size.height)")
        
        let child = ASRatioLayoutSpec(ratio: size.height/size.width, child: imageNode)
        let finalLayoutSpec = ASInsetLayoutSpec(insets: .zero, child: child)
        return finalLayoutSpec
        
//        var imageRatio: CGFloat = 0.5
//        if imageNode.image != nil {
//            imageRatio = (imageNode.image?.size.height)! / (imageNode.image?.size.width)!
//        }
//        
//        let imagePlace = ASRatioLayoutSpec(ratio: imageRatio, child: imageNode)
//        
//        let stackLayout = ASStackLayoutSpec.horizontal()
//        stackLayout.justifyContent = .start
//        stackLayout.alignItems = .start
//        stackLayout.style.flexShrink = 1.0
//        stackLayout.children = [imagePlace]
//        
//        return  ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: stackLayout)
    }


}


