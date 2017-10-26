//
//  NewsModel.swift
//  SAS Coffee
//
//  Created by Duy Cao on 10/27/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import SwiftDate
import String_Extensions
import Foundation
import Realm
import RealmSwift
import ObjectMapper

class NewsModel: PromotionModel {
    static let IMG = "img"
    static let FULL_DES = "fullDescription"
    static let BRANCH = "branch"
    
    
    dynamic var img : String = ""
    dynamic var branch : BranchModel?
    dynamic var fullDes : String = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.img <- map[NewsModel.IMG]
        self.branch <- map[NewsModel.BRANCH]
        self.fullDes <- map[NewsModel.FULL_DES]
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
