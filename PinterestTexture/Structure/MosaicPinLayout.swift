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
    
    
    /// Need to save it because of func `collectionViewContentSize`
    private var contentHeight: CGFloat  = 0.0
    
    private var textNodeSize: CGFloat = 40.0
    
    var flowContentInset: UIEdgeInsets  {
        return UIEdgeInsets(top: minimumLineSpacing, left: minimumInteritemSpacing, bottom: minimumLineSpacing, right: minimumInteritemSpacing)
    }
    
    private var contentGeneralWidth: CGFloat {
        return collectionView!.bounds.width //- (flowContentInset.left + flowContentInset.right)
    }
    
    private var contentWidthWithoutSpacing: CGFloat {
        return contentGeneralWidth - offsetGeneralWidth
    }
    
    /// Need for calculate inserts and item size
    /// Count of interitem spacings always bigger then numberOfColumns, so adding 1
    private var offsetGeneralWidth: CGFloat {
        return minimumInteritemSpacing * CGFloat(numberOfColumns + 1)
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
        
        let columnWidth = contentWidthWithoutSpacing / CGFloat(numberOfColumns)
        var xOffset = calculateXOffsetForItems(with: columnWidth)
        var yOffset = [CGFloat](repeating: minimumLineSpacing, count: numberOfColumns)
        
        let numberOfSections: NSInteger = collectionView.numberOfSections
        
        guard numberOfSections > 0 else {
            return
        }
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {

            let indexPath = IndexPath(item: item, section: 0)

            let cellSize = delegate.collectionView(collectionView, layout: self, originalItemSizeAtIndexPath: indexPath)
        
            let columnHeigth = (cellSize.height * columnWidth) / cellSize.width
            
            var shortestColumn = 0
            if let minYOffset = yOffset.min() {
                shortestColumn = yOffset.index(of: minYOffset) ?? 0
            }
            
            let frame = CGRect(x: xOffset[shortestColumn], y: yOffset[shortestColumn], width: columnWidth, height: columnHeigth+textNodeSize)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)

            contentHeight = max(contentHeight+textNodeSize, frame.maxY)
            
//            print("#\(indexPath.row): contentHeight = \(contentHeight)")

            yOffset[shortestColumn] = yOffset[shortestColumn] + columnHeigth + 1.5*textNodeSize
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

//MARK: Different calculations
extension MosaicPinLayout {

    
    /**
        - Parameter columnWidth: Fixed width for each item in column
        - Returns: Fixed array of X points where flow will create each new item.
     */
    func calculateXOffsetForItems(with columnWidth: CGFloat) -> [CGFloat] {
       
        var xOffset = [CGFloat]()
        
        for column in 0 ..< numberOfColumns {
            
            var offset = CGFloat(column) * columnWidth
            
            offset = offset + minimumInteritemSpacing
            if column.boolValue { offset = offset + minimumInteritemSpacing }
            
            xOffset.append(offset)
        }
        
        return xOffset
        
    }
    
}
