//
//  AppSetting.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/2/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class AppSetting: NSObject {
    private static var appSetting : AppSetting!
    
    
    var mainUser : UserModel!
    
    private override init() {
        
    }
    
    static func sharedInstance() -> AppSetting {
        if AppSetting.appSetting == nil {
            AppSetting.appSetting = AppSetting()
            appSetting.mainUser = UserModel.init()
        }
        return AppSetting.appSetting
    }
    
    
}
