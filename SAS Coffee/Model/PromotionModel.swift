//
//  PromotionModel.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/14/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import SwiftDate
import String_Extensions
import Foundation
import Realm
import RealmSwift
import ObjectMapper

class PromotionModel: SuperModel {
    static let DESC = "description"
    static let EXPIRE = "dateExpired"
    static let DISCOUNT = "discount"
    static let PROMOCODE = "promoCode"
    
    
    dynamic var descript : String = ""
    dynamic var discount : Int = 0
    dynamic var expireDate : Date? = nil
    
    
    
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map[PromotionModel.PROMOCODE]
        descript <- map[PromotionModel.DESC]
        discount <- map[PromotionModel.DISCOUNT]
        let strtime = map.JSON[PromotionModel.EXPIRE] as! String
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "MMM d,yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        self.expireDate = formatter.date(from: strtime)
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(id: Int, name: String) {
        super.init(id: id, name: name)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    
}
