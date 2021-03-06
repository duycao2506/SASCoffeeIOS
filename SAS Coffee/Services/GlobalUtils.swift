//
//  GlobalUtils.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//


import UIKit
import FontAwesomeKit
import NVActivityIndicatorView

class GlobalUtils  : NSObject {
    
    static let mail = "saigonamericanenglish@gmail.com"
    
    static func stringClassFromString(_ className: String) -> AnyClass! {
        
        /// get namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        
        /// get 'anyClass' with classname and namespace
        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!;
        
        // return AnyClass!
        return cls;
    }
    
    static func getDefaultSizeImage(fakmat : FAKMaterialIcons) -> UIImage{
        return fakmat.image(with: CGSize(width: 24*UIScreen.main.scale, height: 24*UIScreen.main.scale))
    }
    
    static func getDefaultSizeImage(fakawe : FAKFontAwesome) -> UIImage{
        return fakawe.image(with: CGSize(width: 24*UIScreen.main.scale, height: 24*UIScreen.main.scale))
    }

    static func loadView(nibName : String, owner : Any) -> UIView{
        return Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?[0] as! UIView
    }
    
    static func checkEmail(checkStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: checkStr)
    }
    
    static func getNVIndicatorView(color: UIColor, type : NVActivityIndicatorType) -> NVActivityIndicatorView {
        let indicator = NVActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50) )
        
        indicator.padding = 16
        indicator.color = color
        
        indicator.type = type
        return indicator
    }
    
}

