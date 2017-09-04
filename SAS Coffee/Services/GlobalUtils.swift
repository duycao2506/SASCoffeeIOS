//
//  GlobalUtils.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//


import UIKit
import FontAwesomeKit


class GlobalUtils  : NSObject {
    static func stringClassFromString(_ className: String) -> AnyClass! {
        
        /// get namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        
        /// get 'anyClass' with classname and namespace
        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!;
        
        // return AnyClass!
        return cls;
    }
    
    static func getDefaultSizeImage(fak : FAKMaterialIcons) -> UIImage{
        return fak.image(with: CGSize(width: 24*UIScreen.main.scale, height: 24*UIScreen.main.scale))
    }

    static func loadView(nibName : String, owner : Any) -> UIView{
        return Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?[0] as! UIView
    }
}

