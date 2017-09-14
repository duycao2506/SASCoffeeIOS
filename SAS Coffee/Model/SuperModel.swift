//
//  SuperModel.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import ObjectMapper

class SuperModel: Object, Mappable{
    static let ID = "id"
    static let NAME = "name"
    
    dynamic var id : Int = 0
    dynamic var name: String = ""
    required public init(id: Int, name :String ) {
        super.init()
        self.id = id
        self.name = name
    }
    
    override static func primaryKey() -> String? {
        return SuperModel.ID
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        self.id    <- map[SuperModel.ID]
        self.name  <- map[SuperModel.NAME]
    }
    
}
