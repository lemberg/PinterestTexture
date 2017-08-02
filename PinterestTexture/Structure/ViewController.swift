//
//  ViewController.swift
//  TextureDemo
//
//  Created by Hellen Soloviy on 7/31/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import UIKit
import PinterestSDK


//Start Controller
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authPinterest(_ sender: UIButton!) {
        
        print("Let's start it!")
        authentificate()
        
    }
    
    func authentificate() {
        
        PDKClient.sharedInstance().authenticate(withPermissions: [PDKClientReadPublicPermissions,PDKClientWritePublicPermissions, PDKClientReadRelationshipsPermissions,PDKClientWriteRelationshipsPermissions], from: self, withSuccess: { (responseObject) in
            
            PDKClient.sharedInstance().getAuthenticatedUserPins(withFields: ["id", "image", "note"], success: { (responseObject) in
                
                let vc = PinsViewController(with: responseObject)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, andFailure: { (error) in
                print("Error || - \(error?.localizedDescription ?? "No description provided")")
            })
            
            
        }) { (error) in
            print("Error - \(error?.localizedDescription ?? "No description provided")")
            
        }
        
    }
    
}

