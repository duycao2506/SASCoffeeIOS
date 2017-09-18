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
    let GG_SERVER_CLIENT_ID = "857542695816-ieqbbqscv4uittao58doqo9kvptnetgs.apps.googleusercontent.com"
    let GG_IOS_CLIENT_ID = "857542695816-5s2uqif28482e052rdojrl3plfeeis6n.apps.googleusercontent.com"
    let GG_API_MAP_KEY = "AIzaSyB4Fzyc870PX12-flZ5AwPgEB1CknvZAZI"
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
