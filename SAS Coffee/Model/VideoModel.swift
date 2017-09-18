//
//  VideoModel.swift
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


class VideoModel: SuperModel {
    static let LENGTH = "length"
    static let VIDEOID = "videoId"
    
    dynamic var videoId: String = ""
    dynamic var length : String = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        videoId <- map[VideoModel.VIDEOID]
        length <- map[VideoModel.LENGTH]
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
