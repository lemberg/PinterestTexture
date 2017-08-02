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
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let size = CGSize(width: object.width, height: object.height)
        print("Size - - w: \(size.width) h: \(size.height)")
        
        let child = ASRatioLayoutSpec(ratio: size.height/size.width, child: imageNode)
        let finalLayoutSpec = ASInsetLayoutSpec(insets: .zero, child: child)
        return finalLayoutSpec

    }


}


