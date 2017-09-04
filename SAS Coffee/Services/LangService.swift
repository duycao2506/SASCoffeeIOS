
//
//  LangService.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class LangService: NSObject {

    
    private override init (){
        
    }
    
    private static var instance : DefaultString!
    private static var langName : LangName = .EN
    
    class func shareInstance() -> DefaultString {
        if instance == nil {
            instance = DefaultString.init()
        }
        return instance
    }
    
    class func changeLang(lang : LangName){
        instance = (GlobalUtils.stringClassFromString(lang.rawValue) as! DefaultString.Type).init()
    }
    
    
}
