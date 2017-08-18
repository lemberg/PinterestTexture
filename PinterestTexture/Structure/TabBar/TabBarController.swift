//
//  TabBarController.swift
//  PinterestTexture
//
//  Created by Hellen Soloviy on 8/3/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit
import PinterestSDK
import PKHUD

class MainController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //work with PinsFeedVC
        let pinsTabController = PinsViewController()
        let pinsTabBarItem = UITabBarItem(title: "", image: UIImage(named: "iconTabBarPins.png"), selectedImage: UIImage(named: "iconTabBarPins.png"))
        pinsTabController.tabBarItem = pinsTabBarItem
        
        //work with BoardsList
        let boardsTabController = BoardsListVC()
        let boardsTabBarItem = UITabBarItem(title: "", image: UIImage(named: "iconTabBarBoards.png"), selectedImage: UIImage(named: "iconTabBarBoards.png"))
        pinsTabController.tabBarItem = boardsTabBarItem
        
        self.viewControllers = [pinsTabController, boardsTabController]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: Delegate
    func tabBarController(_ tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
}
