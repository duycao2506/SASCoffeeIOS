//
//  DataService.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/14/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import ObjectMapper

class DataService: NSObject {
    
    static func assignUser(response : [String:Any], vc : KasperViewController) -> Bool{
        let succ = (response["statuskey"] as! Bool)
        if succ {
            let basicuser = response["data"] as! [String: Any]
            let token = response["token"] as! String
            AppSetting.sharedInstance().mainUser = UserModel.init()
            AppSetting.sharedInstance().mainUser.mapping(map: Map.init(mappingType: .fromJSON, JSON: basicuser ))
            AppSetting.sharedInstance().mainUser.token = token
            return true
        }else{
            vc.notiTextview?.text = response["message"] as? String
            vc.showNotification()
            return false
        }
    }
    
    static func parsePromotionList(response : [[String:Any]]) -> [PromotionModel]{
        var promotions : [PromotionModel] = [PromotionModel]()
        for item in response {
            var promotion : PromotionModel!
            if let eventkey = item[PromoEventModel.FULL_DESC] {
                promotion = PromoEventModel.init()
            }else{
                promotion = PromoVisitModel.init()
            }
            promotion.mapping(map: Map.init(mappingType: .fromJSON, JSON: item))
            promotions.append(promotion)
        }
        return promotions
    }
    
    static func parseBranchList (response: [[String : Any]]) -> [BranchModel]{
        var branches : [BranchModel] = [BranchModel].init()
        for item in response {
            let branch = BranchModel.init()
            branch.mapping(map: Map.init(mappingType: .fromJSON, JSON: item))
            branches.append(branch)
        }
        return branches
    }
    
    static func parseDictionary(resp : [[String : Any]]) -> [DictionaryModel]{
        var dictions : [DictionaryModel] = [DictionaryModel].init()
        for item in resp {
            let dict = DictionaryModel.init()
            dict.mapping(map: Map.init(mappingType: .fromJSON, JSON: item))
            dictions.append(dict)
        }
        return dictions
    }
    
    static func parseTopics (resp : [[String:Any]]) -> [TopicModel]{
        var topics : [TopicModel] = [TopicModel].init()
        for item in resp {
            let topic = TopicModel.init()
            topic.mapping(map: Map.init(mappingType: .fromJSON, JSON: item))
            topics.append(topic)
        }
        return topics
    }
    
    static func parseVideos(resp: [[String:Any]]) -> [VideoModel] {
        var videos : [VideoModel] = [VideoModel].init()
        for item in resp {
            let vid = VideoModel.init()
            vid.mapping(map: Map.init(mappingType: .fromJSON, JSON: item))
            videos.append(vid)
        }
        return videos
    }
    
    static func findEventByIdInPromotionList(id : Int, promotelistRaw : [[String : Any]]) -> PromoEventModel? {
        for item in promotelistRaw {
            if let check = item[PromoEventModel.FULL_DESC], (item["id"] as! Int) == id{
                let event = PromoEventModel.init()
                event.mapping(map: Map.init(mappingType: .fromJSON, JSON: item))
                return event
            }
        }
        return nil
    }
}
