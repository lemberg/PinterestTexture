//
//  BoardNode.swift
//  PinterestTexture
//
//  Created by Hellen Soloviy on 8/7/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import UIKit
import PinterestSDK
import AsyncDisplayKit

class BoardNode: ASCellNode {
    
//    var zeroImageNode: ASNetworkImageNode = ASNetworkImageNode()
//    var firstImageNode: ASNetworkImageNode = ASNetworkImageNode()
//    var secodImageNode: ASNetworkImageNode = ASNetworkImageNode()
//    var thirdImageNode: ASNetworkImageNode = ASNetworkImageNode()
//    var forthImageNode: ASNetworkImageNode = ASNetworkImageNode()
//    var fifthImageNode: ASNetworkImageNode = ASNetworkImageNode()
//    var sixImageNode: ASNetworkImageNode = ASNetworkImageNode()
//    var sevenImageNode: ASNetworkImageNode = ASNetworkImageNode()
    
    var imageNodeArray: [ASNetworkImageNode] = Array(repeating: ASNetworkImageNode(), count: 8)

    var nameNode: ASTextNode = ASTextNode()
    var dateNode: ASTextNode = ASTextNode()

    var object: PDKBoard
    
    init(pin: PDKBoard) {
        self.object = pin
        
        super.init()
        
        imageNodeArray.forEach {
            
            $0.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1)
            self.addSubnode($0)
            
        }
        
//        imageNode.url = URL(string: pin.url)
//        imageNode.delegate = self
//        self.addSubnode(imageNode)
//
//        commentNode = ASTextNode()
//        commentNode.maximumNumberOfLines = 2
//        commentNode.attributedText = NSAttributedString(string: object.descriptionText, attributes: [NSForegroundColorAttributeName:#colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)])
//        
//        self.addSubnode(commentNode)
//        
//        self.borderColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1).cgColor
//        self.borderWidth = 1.0
        
    }
    
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        
//        let size = CGSize(width: object.width, height: object.height)
//        
//        let child = ASRatioLayoutSpec(ratio: size.height/size.width, child: imageNode)
//        var insets = UIEdgeInsetsMake(0, 0, 0, 0)
//        
//        let finalImageLayoutSpec = ASInsetLayoutSpec(insets: insets, child: child)
//        
//        insets = UIEdgeInsets(top: 0, left: 8, bottom: 4, right: 8)
//        let finalTextLayoutSpec = ASInsetLayoutSpec(insets: insets, child: commentNode)
//        
//        let mainSpec = ASStackLayoutSpec(direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .start, children: [finalImageLayoutSpec,finalTextLayoutSpec])
//        
//        return mainSpec
//    }
//    
    
    
}

extension BoardNode: ASNetworkImageNodeDelegate {
    
    public func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        
    }
    
    
}


