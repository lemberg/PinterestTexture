//
//  BoardsListVC.swift
//  PinterestTexture
//
//  Created by Hellen Soloviy on 8/3/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit
import PinterestSDK
import AsyncDisplayKit
import PKHUD

class BoardsListVC: ASViewController<ASCollectionNode> {
    
    var pins = [Pin]()
    
    var collectionNode: ASCollectionNode
    
    init(with response: PDKResponseObject? = nil) {
        
        print("init")
        
        let flowLayout = BoardsFlowLayout()
        
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        
        collectionNode = ASCollectionNode(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        //        collectionNode.view.allowsSelection = false
        collectionNode.backgroundColor = .white
        
        super.init(node: collectionNode)
        
        self.collectionNode.frame = self.view.bounds
        
//        flowLayout.delegate = self
        collectionNode.delegate = self
        collectionNode.dataSource = self
        
        PDKClient.sharedInstance().getAuthenticatedUserPins(withFields: ["id", "image", "note"], success: { (responseObject) in
            self.responseCheck(with: responseObject)
            
        }, andFailure: { (error) in
            print("Error || - \(error?.localizedDescription ?? "No description provided")")
        })
    }
    
    //TODO: need to do something with it
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func responseCheck(with response: PDKResponseObject?) {
        
        if let responseObject = response {
            if let pins = responseObject.pins() as? [PDKPin] {
                
                let pinsModelArray = pins.flatMap({ Pin(with: $0) })
                self.pins = pinsModelArray
                
                self.collectionNode.reloadData()
                //                HUD.flash(.success, delay: 1.0)
                
            } else {
                print("WARNING: Yup! Pins have not correct format!")
            }
            
        } else {
            print("WARNING: Error! No pins here!")
        }
        
    }
    
    func setupCollectionNode() {
        
        
    }
    
    
}

extension BoardsListVC: ASCollectionDelegate {
    
}

extension BoardsListVC: ASCollectionDataSource {
    
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

//extension BoardsListVC: BoardsFlowLayoutDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, layout: MosaicPinLayout, originalItemSizeAtIndexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: pins[originalItemSizeAtIndexPath.row].width, height: pins[originalItemSizeAtIndexPath.row].height)
//    }
//    
//    
//}
