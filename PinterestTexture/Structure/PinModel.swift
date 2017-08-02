//
//  PinModel.swift
//  TextureDemo
//
//  Created by Hellen Soloviy on 8/1/17.
//  Copyright © 2017 Lemberg Solutions Limited. All rights reserved.
//

import Foundation
import UIKit
import PinterestSDK


class Pin {
    
    fileprivate var _id: String
    fileprivate var _url: String
    fileprivate var _width: Int
    fileprivate var _height: Int
    
    var id: String {
        get {
            return _id
        }
        
    }
    
    
    var url: String {
        get {
            return _url
        }
        
    }
    
    var width: Int {
        get {
            return _width
        }
        
    }
    
    var height: Int {
        get {
            return _height
        }
        
    }
    
    init(with pin: PDKPin) {
        
        self._id = pin.identifier
        
        if let imageData = pin.images[PinConstants.original], let original = imageData as? [String:AnyObject] {
            
            if let url = original[PinConstants.url] as? String {
                self._url = url
            } else {
                self._url = "http://e-shuushuu.net/images/2016-08-29-856644.png"
            }
            
            
            if let width = original[PinConstants.width] as? Int {
                self._width = width
            } else {
                self._width = 44
            }
            
            
            if let height = original[PinConstants.height] as? Int {
                self._height = height
            } else {
                self._height = 80
            }
            
        } else {
            self._url = "http://e-shuushuu.net/images/2016-08-29-856644.png"
            self._width = 44
            self._height = 80
        }
        
    
    }
}
