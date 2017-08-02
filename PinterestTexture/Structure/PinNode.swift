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
        
//        commentNode.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.addSubnode(commentNode)

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        print("Size - - : \(constrainedSize.min)")
        
        let size = CGSize(width: object.width, height: object.height)
        print("Size - - w: \(size.width) h: \(size.height)")

        let child = ASRatioLayoutSpec(ratio: size.height/size.width, child: imageNode)
        var insets = UIEdgeInsetsMake(0, 0, 0, 0)

        let finalImageLayoutSpec = ASInsetLayoutSpec(insets: insets, child: child)
        
        insets = UIEdgeInsets(top: 0, left: 8, bottom: 4, right: 8)
        let finalTextLayoutSpec = ASInsetLayoutSpec(insets: insets, child: commentNode)
        
//        let width = Int(constrainedSize.max.width)
//        let height = (width * (object.height - 20)) / object.width
//
//        imageNode.style.preferredSize = CGSize(width: width, height: height)
//        commentNode.style.preferredSize = CGSize(width: width, height: 20)

        let mainSpec = ASStackLayoutSpec(direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .start, children: [finalTextLayoutSpec, finalImageLayoutSpec])

//        return finalImageLayoutSpec

        return mainSpec
//
//        let photoDimension: CGFloat = constrainedSize.max.width / 4.0
//        imageNode.style.preferredSize = CGSize(width: photoDimension, height: photoDimension)
        
        // INFINITY is used to make the inset unbounded
//        let insets = UIEdgeInsets(top: CGFloat.infinity, left: 8, bottom: 4, right: 8)
//        let textInsetSpec = ASInsetLayoutSpec(insets: insets, child: commentNode)
        
//        return ASOverlayLayoutSpec(child: finalImageLayoutSpec, overlay: textInsetSpec)
    }

}


