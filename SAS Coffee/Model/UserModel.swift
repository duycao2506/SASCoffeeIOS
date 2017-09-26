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
    //static
    static let EMAIL = "email"
    static let PHONE = "phone"
    static let USERCODE = "userCode"
    static let AVATAR = "avatar"
    static let FBID = "fbId"
    static let BIRTHDAY = "birthday"
    static let ADDRESS = "address"
    static let PASSWORD = "password"
    static let CHECKIN = "checkIn"
    static let BRAID = "branchId"
    static let TYPE = "type"
    
    
    
    
    
    //dynamic
    dynamic var email: String = ""
    dynamic var phone : String = "Not available".localize()
    dynamic var password : String = ""
    dynamic var userCode : String = ""
    dynamic var avatar : String = ""
    dynamic var birthday : Date? = nil
    dynamic var fbId : String = ""
    dynamic var point : Int = 0
    dynamic var address: String = "Not available".localize()
    dynamic var checkIntime : Int = 0
    dynamic var token : String = ""
    dynamic var userType : String = ""
    dynamic var branchId : Int = 0
    
    required init() {
        super.init()
    }
    
    init(id: Int,
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
        phone         <- map[UserModel.PHONE]
        email      <- map[UserModel.EMAIL]
        userCode       <- map[UserModel.USERCODE]
        avatar  <- map[UserModel.AVATAR]
        fbId  <- map[UserModel.FBID]
        checkIntime <- map[UserModel.CHECKIN]
        address <- map[UserModel.ADDRESS]
        password <- map[UserModel.PASSWORD]
        branchId <- map[UserModel.BRAID]
        userType <- map[UserModel.TYPE]
        
        if let bdstring = map.JSON[UserModel.BIRTHDAY] {
            let formatter = DateFormatter.init()
            formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
            formatter.dateFormat = "MMM d,yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            self.birthday = formatter.date(from: bdstring as! String)
        }
    }
    
    
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required public init(id: Int, name: String) {
        fatalError("init(id:name:) has not been implemented")
    }
    
    
    
}
