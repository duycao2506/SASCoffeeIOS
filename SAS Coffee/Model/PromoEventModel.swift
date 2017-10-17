//
//  PromoEventModel.swift
//  SAS Coffee
//
//  Created by Duy Cao on 10/18/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import SwiftDate
import String_Extensions
import Foundation
import Realm
import RealmSwift
import ObjectMapper

class PromoEventModel: PromotionModel {

    static let FULL_DESC = "fullDescription"
    static let BRANCH = "branch"
    
    
    dynamic var fullDes : String = ""
    dynamic var branch : BranchModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.branch <- map[PromoEventModel.BRANCH]
        self.fullDes <- map[PromoEventModel.FULL_DESC]
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
