//
//  TitleView.swift
//  PinterestTexture
//
//  Created by Hellen Soloviy on 8/17/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit

class TitleViewLayoutAttributes : UICollectionViewLayoutAttributes {
    var title = ""
}

class TitleView : UICollectionReusableView {
    
    weak var lab : UILabel!
    // ... the rest as before ...
    
    override func apply(_ atts: UICollectionViewLayoutAttributes) {
        if let atts = atts as? TitleViewLayoutAttributes {
            self.lab.text = atts.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        let lab = UILabel(frame:self.bounds)
        self.addSubview(lab)
        lab.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lab.font = UIFont(name: "GillSans-Bold", size: 40)
        lab.text = "Testing"
        self.lab = lab
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
