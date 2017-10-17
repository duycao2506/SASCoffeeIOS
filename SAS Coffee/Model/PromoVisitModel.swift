//
//  PromoVisitModel.swift
//  SAS Coffee
//
//  Created by Duy Cao on 10/18/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import SwiftDate
import String_Extensions
import Foundation
import Realm
import RealmSwift
import ObjectMapper

class PromoVisitModel: PromotionModel {
    static let USER = "user"
    
    
    dynamic var promocode : String = ""
    dynamic var user : UserModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.user <- map[PromoVisitModel.USER]
        self.promocode <- map[PromotionModel.PROMOCODE]
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
