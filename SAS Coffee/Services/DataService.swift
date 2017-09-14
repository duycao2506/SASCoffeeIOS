//
//  DataService.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/14/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import ObjectMapper

class DataService: NSObject {
    
    static func assignUser(response : [String:Any], vc : KasperViewController) -> Bool{
        let succ = (response["statuskey"] as! Bool)
        if succ {
            let basicuser = response["data"] as! [String: Any]
            let token = response["token"] as! String
            AppSetting.sharedInstance().mainUser.mapping(map: Map.init(mappingType: .fromJSON, JSON: basicuser ))
            AppSetting.sharedInstance().mainUser.token = token
            return true
        }else{
            vc.notiTextview?.text = response["message"] as? String
            vc.showNotification()
            return false
        }
    }
    
    static func parsePromotionList(response : [[String:Any]]) -> [PromotionModel]{
        var promotions : [PromotionModel] = [PromotionModel]()
        for item in response {
            var promotion = PromotionModel.init()
            promotion.mapping(map: Map.init(mappingType: .fromJSON, JSON: item))
            promotions.append(promotion)
        }
        return promotions
    }
}
