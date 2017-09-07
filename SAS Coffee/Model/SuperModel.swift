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
    
    var id : String = ""
    var name: String = ""
    required public init(id: String, name :String ) {
        super.init()
        self.id = id
        self.name = name
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id    <- map[SuperModel.ID]
        name  <- map[SuperModel.NAME]
    }
    
}
