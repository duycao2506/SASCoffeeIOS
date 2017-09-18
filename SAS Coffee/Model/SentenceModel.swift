//
//  SentenceModel.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/17/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit


import SwiftDate
import String_Extensions
import Foundation
import Realm
import RealmSwift
import ObjectMapper

class SentenceModel: SuperModel {
    static let SENTENCE_EN = "sentenceEn"
    static let SENTENCE_VI = "sentenceVi"
    
    dynamic var sentenceEn : String = ""
    dynamic var sentenceVi : String = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.sentenceEn <- map[SentenceModel.SENTENCE_EN]
        self.sentenceVi <- map[SentenceModel.SENTENCE_VI]
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
