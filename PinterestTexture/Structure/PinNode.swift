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
    var commentNode: ASTextNode = ASTextNode()

    var object: Pin
    
    init(pin: Pin) {
        self.object = pin
        
        super.init()
        
        imageNode.url = URL(string: pin.url)
        self.addSubnode(imageNode)
        
        commentNode = ASTextNode()
        commentNode.maximumNumberOfLines = 3
        commentNode.attributedText = NSAttributedString(string: "Some special text for testing textNode", attributes: [NSForegroundColorAttributeName:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        self.addSubnode(commentNode)

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        print("Size - - : \(constrainedSize.min)")
        
        let size = CGSize(width: object.width, height: object.height)
        print("Size - - w: \(size.width) h: \(size.height)")

        let child = ASRatioLayoutSpec(ratio: size.height/size.width, child: imageNode)
        let finalImageLayoutSpec = ASInsetLayoutSpec(insets: .zero, child: child)
        
        let finalTextLayoutSpec = ASInsetLayoutSpec(insets: .zero, child: commentNode)
        
        let mainSpec = ASStackLayoutSpec(direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .start, children: [finalImageLayoutSpec, finalTextLayoutSpec])

        return mainSpec
        
    }

}


