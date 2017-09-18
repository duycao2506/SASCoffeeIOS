//
//  TopicModel.swift
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

class TopicModel: SuperModel {
    static let NAMEVI = "nameVi"
    static let SENTENCE_LIST = "sentenceList"
    
    dynamic var nameVi: String = ""
    let sentenceList : List<SentenceModel> = List<SentenceModel>()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.nameVi <- map[TopicModel.NAMEVI]
        let sentences = map.JSON[TopicModel.SENTENCE_LIST] as! [[String : Any]]
        for sentence in sentences {
            let sentmodel = SentenceModel.init()
            sentmodel.mapping(map: Map.init(mappingType: .fromJSON, JSON: sentence))
            self.sentenceList.append(sentmodel)
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
