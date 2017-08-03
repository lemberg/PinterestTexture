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
    
    //TODO: fix it
    //Default data until this is development
    fileprivate var _url: String = "http://e-shuushuu.net/images/2016-08-29-856644.png"

    fileprivate var _width: Int = 44
    fileprivate var _height: Int = 80
    
    fileprivate var _descriptionText: String
    
    fileprivate var _board: PDKBoard
    
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
    
    
    var descriptionText: String {
        get {
            return _descriptionText
        }
        
    }

    var board: PDKBoard {
        get {
            return _board
        }
        
    }

    
    init(with pin: PDKPin) {
        
        self._id = pin.identifier
        self._descriptionText = pin.descriptionText
        self._board = pin.board
        
        if let imageData = pin.images[PinConstants.original], let original = imageData as? [String:AnyObject] {
            
            if let url = original[PinConstants.url] as? String {
                self._url = url
            }
            
            
            if let width = original[PinConstants.width] as? Int {
                self._width = width
            }
            
            
            if let height = original[PinConstants.height] as? Int {
                self._height = height
            }
            
        }
        
    
    }
}
