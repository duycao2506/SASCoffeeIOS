//
//  UserModel.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import SwiftDate
import String_Extensions
import Foundation
import Realm
import RealmSwift
import ObjectMapper

class UserModel: SuperModel {
    dynamic var email: String = ""
    dynamic var phone : String = ""
    dynamic var password : String = ""
    dynamic var userCode : String = ""
    dynamic var avatar : String = ""
    dynamic var birthday : Date = Date()
    dynamic var fbId : String = ""
    dynamic var point : Int = 0
    dynamic var address: String = ""
    dynamic var checkIntime : Int = 0
    
    var accessToken : String = ""
    
    required init() {
        super.init()
    }
    
    init(id: String,
         name: String,
         email: String,
         phone: String,
         password : String,
         userCode : String,
         avatar : String,
         birthday : String,
         address: String,
         checkTime : Int,
         fbId : String){
        
        super.init(id: id, name: name)
        
        self.email = email
        self.phone = phone
        self.password = password
        self.userCode = userCode
        self.avatar = avatar
        self.birthday = birthday.toDate("dd/MM/yyyy")!
        self.address = address
        self.checkIntime = checkTime
        self.fbId = fbId
        self.point = 10
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        phone         <- map["phone"]
        email      <- map["email"]
        userCode       <- map["code"]
        avatar  <- map["avatar"]
        fbId  <- map["fbId"]
        birthday    <- (map["birthday"], DateTransform())
    }
    
    
    required public init(id: String, name: String) {
        fatalError("init(id:name:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
    
}
