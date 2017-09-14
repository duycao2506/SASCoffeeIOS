
//
//  RequestService.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/2/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import Alamofire

class RequestService: NSObject {
    
    static var isInternetOk = true
    static let SERVER_URL = "http://192.168.1.6:8080/sascoffee/sas_server/";
    
    static let GET_SPLASH_NEWS = "user/getNews/"; //
    static let POST_LOGIN_FB = "user/loginFacebook"; //
    static let POST_LOGIN_GMAIL = "user/loginGmail"; //
    static let POST_LOGIN_AUTO = "user/autoLogin"; //
    
    static let GET_PROMO_BY_USER_ID = "promo/"; //
    static let DELETE_PROMO_BY_ID = "promo/delete/"; //
    
    static let GET_ALL_BRANCH = "branch/getAll/"; //
    
    static let ADMIN_UPGRADE_USER = "admin/upgrade/";
    
    static let GOOGLE_TRANSLATE = "https://translation.googleapis.com/language/translate/v2";
    static let DICTIONARY = "https://api.pearson.com/v2/dictionaries/ldoce5/entries";
    
    static let GET_ALL_VIDEO = "study/video/getAll/"; //
    static let GET_ALL_TOPIC = "study/conversation/getAll/"; //
    static let GET_MEMBER_LIST = "promo/getMember/";
    static let POST_JOIN_EVENT = "promo/joinEvent/";
    
    
    static func GET_news(memberType : String, complete:  @escaping ((Any?)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_SPLASH_NEWS + memberType, method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                let map = data.result.value as! [String : Any]
                let str = map["news"]
                print("get news \(str)")
                complete(str)
            }else{
                complete(nil)
            }
            
        })
    }
    
    static func GET_all_vid(complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_ALL_VIDEO, method: .get).responseJSON(completionHandler: {
            data -> Void in
            
            print("get all vids \(String(describing: data.data))")
            complete(data.data!)
        })
    }
    
    static func GET_all_topic(complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_ALL_TOPIC, method: .get).responseJSON(completionHandler: {
            data -> Void in
            
            print("get all topics \(String(describing: data.data))")
            complete(data.data!)
        })
    }
    
    static func GET_all_branch(complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_ALL_BRANCH, method: .get).responseJSON(completionHandler: {
            data -> Void in
            
            print("get all branch \(String(describing: data.data))")
            complete(data.data!)
            
        })
    }
    
    static func GET_promo_by( userId: String, complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_PROMO_BY_USER_ID + userId, method: .get).responseJSON(completionHandler: {
            data -> Void in
            print("getpromobyuserid \(String(describing: data.value))")
            complete(data.value!)
        })
    }
    
    static func DELETE_promo (id : String, complete: @escaping ((Any)->())) {
        Alamofire.request(RequestService.SERVER_URL + RequestService.DELETE_PROMO_BY_ID, method: .delete).responseJSON(completionHandler: {
            data -> Void in
            
            print("deletepromo \(String(describing: data.data))")
            complete(data.data!)
        })
    }
    
    static func POST_join_event (params: [String: Any], complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.POST_JOIN_EVENT, method: .post, parameters: params).responseJSON(completionHandler: {
            data -> Void in
            
            print("joinevent \(String(describing: data.data))")
            complete(data.data!)
        })
    }
   
    
    static func POST_login(endpoint: String, token : String, complete: @escaping ((Any)->())){
        var request = URLRequest.init(url: URL.init(string: RequestService.SERVER_URL + endpoint)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = token.data(using: .utf8)
        Alamofire.request(request).responseJSON(completionHandler: {
            data -> Void in
            
            print("login to \(endpoint) \(data.value!)")
            complete(data.value!)
        })
    }
    
    
    
    
}
