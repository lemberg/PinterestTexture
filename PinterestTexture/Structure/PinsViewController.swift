//
//  PinsViewController.swift
//  TextureDemo
//
//  Created by Hellen Soloviy on 7/31/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import UIKit
import PinterestSDK
import AsyncDisplayKit

class PinsViewController: ASViewController<ASCollectionNode> {
    var pins = [Pin]()
    
    var collectionNode: ASCollectionNode
    
//    let layoutInspector = MosaicCollectionViewLayoutInspector()
//    let kNumberOfImages: UInt = 14

    init(with response: PDKResponseObject? = nil) {
        
        print("init")
        
        let flowLayout = MosaicPinLayout()
        flowLayout.numberOfColumns = 3;
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8

        
        collectionNode = ASCollectionNode(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
//        collectionNode.view.allowsSelection = false
        collectionNode.backgroundColor = .white
        
//        collectionNode.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        super.init(node: collectionNode)
        
        self.collectionNode.frame = self.view.bounds

        flowLayout.delegate = self
        collectionNode.delegate = self
        collectionNode.dataSource = self
        
        responseCheck(with: response)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func responseCheck(with response: PDKResponseObject?) {
        
        //po (pins[0].images["original"]! as! [String:Any])["url"]!
        
        print("responseCheck")

        if let responseObject = response {
            
            if let pins = responseObject.pins() as? [PDKPin] {
                
                let pinsModelArray = pins.flatMap({ Pin(with: $0) })
                self.pins = pinsModelArray
                
                print("Yup! Pins are here!")
                
            } else {
                print("Yup! Pins have not correct format!")
            }
            
        } else {
            print("Error! No pins here!")
        }
        
    }
    
    func setupCollectionNode() {

        
    }
    
    
}

extension PinsViewController: ASCollectionDelegate {

}

extension PinsViewController: ASCollectionDataSource {
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return pins.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard pins.count > indexPath.row else { return { ASCellNode() } }
        
        let pinData = self.pins[indexPath.row]
        // this may be executed on a background thread - it is important to make sure it is thread safe
            let cellNodeBlock = { () -> PinNode in
                let cellNode = PinNode(pin: pinData)
                return cellNode
            }
        
        return cellNodeBlock
    }
    
    
}

extension PinsViewController: MosaicPinLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout: MosaicPinLayout, originalItemSizeAtIndexPath: IndexPath) -> CGSize {
        
        return CGSize(width: pins[originalItemSizeAtIndexPath.row].width, height: pins[originalItemSizeAtIndexPath.row].height)
    }
    
    
}






