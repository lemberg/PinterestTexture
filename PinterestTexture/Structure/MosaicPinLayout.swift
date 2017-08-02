//
//  PinLayout.swift
//  TextureDemo
//
//  Created by Hellen Soloviy on 8/1/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import UIKit
import AsyncDisplayKit

protocol MosaicPinLayoutDelegate: ASCollectionDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: MosaicPinLayout, originalItemSizeAtIndexPath: IndexPath) -> CGSize
    
}

class MosaicPinLayout: UICollectionViewFlowLayout {
    
    var delegate: MosaicPinLayoutDelegate!
    var numberOfColumns = 2
    
    /// Array of all attributes for cells in `MosaicPinLayout`
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var cellPadding:CGFloat = 8.0
    
    // Need to save it because of func `collectionViewContentSize`
    private var contentHeight: CGFloat  = 0.0
    
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    
    /**
     
     `yOffset` tracks the last y-offset in each column
     `xOffset` tracks for each column. This is fixed, unlike `yOffset`
     `contentHeight` save heaght for section with items. If don't do this we can have an empty space after our items

     Calculating for each item include find the shortest column to place this item
     
     */
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        cache = [UICollectionViewLayoutAttributes]()
        contentHeight = 0
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }

        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        let numberOfSections: NSInteger = collectionView.numberOfSections
        
        guard numberOfSections > 0 else {
            return
        }
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {

            let indexPath = IndexPath(item: item, section: 0)
            print("column #\(indexPath.row)")

            let cellSize = delegate.collectionView(collectionView, layout: self, originalItemSizeAtIndexPath: indexPath)
        
            let columnHeigth = (cellSize.height * columnWidth) / cellSize.width
            
            print("columnHeigth = \(columnHeigth)")

            var shortestColumn = 0
            if let minYOffset = yOffset.min() {
                print("minYOffset = \(minYOffset) YES!")

                shortestColumn = yOffset.index(of: minYOffset) ?? 0
            }
            
            print("yOffset = \(yOffset)")
            print("shortestColumn = \(shortestColumn)")

            let frame = CGRect(x: xOffset[shortestColumn], y: yOffset[shortestColumn], width: columnWidth, height: columnHeigth)
            
            print("frame = \(frame)")
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            print("insetFrame = \(insetFrame)")

            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            contentHeight = max(contentHeight, frame.maxY)
            
            print("contentHeight = \(contentHeight)")

            yOffset[shortestColumn] = yOffset[shortestColumn] + columnHeigth
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
      
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first { attributes -> Bool in
            return attributes.indexPath == indexPath
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if (!(self.collectionView?.bounds.size.equalTo(newBounds.size))!) {
            return true;
        }
        return false;
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView!.bounds.size.width, height: contentHeight)
    }
    
}
