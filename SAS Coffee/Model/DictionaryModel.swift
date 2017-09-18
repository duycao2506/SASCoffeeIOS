//
//  DictionaryModel.swift
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

class DictionaryModel: SuperModel {
    static let WORD = "headword"
    static let TYPE = "part_of_speech"
    static let IPA = "ipa"
    static let DEF = "definition"
    static let EXAM = "examples"
    static let PRONUNCIATION = "pronunciations"
    static let SENSES = "senses"
    static let TEXT = "text"
    
    dynamic var word: String = ""
    dynamic var type : String = ""
    dynamic var pronun : String = ""
    dynamic var def : String = ""
    dynamic var example : String = ""
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        word <- map[DictionaryModel.WORD]
        type <- map[DictionaryModel.TYPE]
        if let pronuns = map.JSON[DictionaryModel.PRONUNCIATION]{
            let pronunArr = pronuns as! [[String:Any]]
            if let ipa = pronunArr[0][DictionaryModel.IPA]{
                self.pronun = ipa as! String
            }
        }
        
        if !(map.JSON[DictionaryModel.SENSES] is NSNull) {
            let sense0 = (map.JSON[DictionaryModel.SENSES] as! [[String : Any]]) [0]
            
            //Definition
            if let defarr = sense0[DictionaryModel.DEF]{
                let defarray = defarr as! [String]
                for item in defarray {
                    self.def += "\(item), "
                }
                self.def = self.def.substring(0, length: self.def.length - 2)
            }
            
            
            //Example
            if let examArr = sense0[DictionaryModel.EXAM] {
                let examArray = examArr as! [[String:Any]]
                for item in examArray {
                    if let exam = item[DictionaryModel.TEXT] {
                        let examIndividual = exam as! String
                        if !examIndividual.isEmpty {
                            self.example += "\(examIndividual); "
                        }
                        
                    }
                }
                self.example = self.example.substring(0, length: self.example.length - 2)
            }
        }
        
        
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
