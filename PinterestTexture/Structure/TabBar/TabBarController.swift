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
    
//    var pinsTabController: PinsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configurate
        let pinsTabController = PinsViewController()
        let pinsTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "iconTabBarPins.png"), selectedImage: UIImage(named: "iconTabBarPins.png"))
        pinsTabController.tabBarItem = pinsTabBarItem
        
        self.viewControllers = [pinsTabController]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
}
