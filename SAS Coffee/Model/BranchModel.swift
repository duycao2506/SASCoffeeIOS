//
//  BranchModel.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/16/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//
import SwiftDate
import String_Extensions
import Foundation
import Realm
import RealmSwift
import ObjectMapper

class BranchModel: SuperModel {
    static let ADDRESS = "address"
    static let LATITUDE = "latitude"
    static let LONGITUDE = "longitude"
    static let OPEN = "open"
    
    dynamic var address : String = ""
    dynamic var latitude : Double = 0.0
    dynamic var longitude : Double = 0.0
    dynamic var open : String = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        address <- map[BranchModel.ADDRESS]
        latitude <- map[BranchModel.LATITUDE]
        longitude <- map[BranchModel.LONGITUDE]
        open <- map[BranchModel.OPEN]
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
