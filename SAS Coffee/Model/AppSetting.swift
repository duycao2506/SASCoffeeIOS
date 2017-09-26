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
    let GG_SERVER_CLIENT_ID = "616629690165-05bgilah95mcjt7au75co8k8d4fe433f.apps.googleusercontent.com"
    let GG_IOS_CLIENT_ID = "616629690165-s6t1q9i5n4a4t0oo1cc54bgh6n9pob5b.apps.googleusercontent.com"
    let GG_API_MAP_KEY = "AIzaSyDdtT4e4vyC5cY78vh7B9jt8b1Rm1hLUb8"
    let DIC_API_KEY = "wkqpBLMbS0fG9INAwryUDAV1dmaJfTO9"
    
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
