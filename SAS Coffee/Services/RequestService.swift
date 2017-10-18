
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
    
    static let SERVER_URL = "http://35.201.131.125/sas/sas_server/";
    
//    static let SERVER_URL = "http://192.168.1.7:8080/sascoffee/sas_server/"
//    static let SERVER_URL = "http://192.168.1.38:8080/sascoffee/sas_server/"
    
    static let GET_SPLASH_NEWS = "user/getNews/"; //
    static let GET_LOGIN_FB = "user/loginFacebook/"; //
    static let GET_LOGIN_GMAIL = "user/loginGmail/"; //
    static let GET_LOGIN_AUTO = "user/autoLogin/"; //
    
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
    static let POST_LOGIN_EMAIL = "user/loginWithGmail";
    static let POST_REGISTER = "user/register"
    static let GET_CHECK_EMAIL = "user/checkGmail/"
    
    
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
    
    static func GET_memberList(promoId: String, complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_MEMBER_LIST + promoId, method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("get mem list \(String.init(describing: data.value))")
                complete(data.value!)
            }
            
        })
    }
    
    static func GET_all_vid(complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_ALL_VIDEO, method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("get all vids \(String(describing: data.data))")
                complete(data.value!)
            }
            
        })
    }
    
    static func GET_all_topic(complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_ALL_TOPIC, method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("get all topics \(String(describing: data.data))")
                complete(data.value!)
            }
           
        })
    }
    
    static func GET_all_branch(complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_ALL_BRANCH, method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("get all branch \(String(describing: data.data))")
                complete(data.value!)
            }
            
        })
    }
    
    static func GET_promo_by( userId: String, complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_PROMO_BY_USER_ID + userId, method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("getpromobyuserid \(String(describing: data.value))")
                complete(data.value!)
            }
        })
    }
    
    static func DELETE_promo (promoCode : String, userId: String, complete: @escaping ((Any)->())) {
        Alamofire.request(RequestService.SERVER_URL + RequestService.DELETE_PROMO_BY_ID + "\(userId)/\(promoCode)", method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("deletepromo \(String(describing: data.value))")
                complete(data.value!)
            }
        })
    }
    
    static func POST_join_event (eventId : String, userId : String, userName : String, phone : String, complete: @escaping ((Any)->())){
        var pars = [String: Any]()
        pars["userName"] = userName
        pars["phone"] = phone
        Alamofire.request(RequestService.SERVER_URL + RequestService.POST_JOIN_EVENT + "\(eventId)/\(userId)" , method: .post, parameters: pars, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("joinevent \(String(describing: data.value))")
                complete(data.value!)
            }
        })
    }
   
    
    static func GET_login(endpoint: String, token : String, complete: @escaping ((Any)->())){
        var request = URLRequest.init(url: URL.init(string: RequestService.SERVER_URL + endpoint + token)!)
        request.httpMethod = HTTPMethod.get.rawValue
        Alamofire.request(request).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("login to \(endpoint) \(data.value!)")
                complete(data.value!)
            }
        })
    }
    
    static func POST_translate(input : String, isToEng: Bool, complete : @escaping ((Any)->())){
        var pars = [String : Any]()
        pars["source"] = isToEng ? "vi" : "en"
        pars["target"] = isToEng ? "en" : "vi"
        pars["q"] = input
        let lnk = RequestService.GOOGLE_TRANSLATE + "?key=\(AppSetting.sharedInstance().GG_API_MAP_KEY)"
        Alamofire.request(lnk  , method: .post , parameters: pars, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("translate \(data.value!)")
                complete(data.value!)
            }
        })
    }
    
    static func GET_word_fam(input : String, complete: @escaping ((Any?)->())){
        let lnk = RequestService.DICTIONARY + "?key=\(AppSetting.sharedInstance().DIC_API_KEY)&headword=\(input)"
        Alamofire.request(lnk, method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("dictionary \(data.value!)")
                complete(data.value!)
            }else{
                complete(nil)
            }
        })
    }
    
    static func GET_check_email(email: String, complete: @escaping ((Any)->())){
        Alamofire.request(RequestService.SERVER_URL + RequestService.GET_CHECK_EMAIL + email, method: .get).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("check emai \(String(describing: data.value))")
                complete(data.value!)
            }
        })
    }
    
    static func POST_loginWithEmail (email : String , password : String, complete : @escaping ((Any)->())){
        var params : [String : Any] = [String : Any].init()
        params["email"] = email
        params["password"] = password
        Alamofire.request(RequestService.SERVER_URL + RequestService.POST_LOGIN_EMAIL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess {
                print("login email \(String(describing: data.value))")
                complete(data.value!)
            }
            
        })
    }
    
    static func POST_register(user: UserModel, complete: @escaping ((Any)->())){
        var registeruser = user.toJSON()
        print(registeruser)
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "MMM dd, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        registeruser[UserModel.BIRTHDAY] = formatter.string(from: user.birthday!)
        
        Alamofire.request(RequestService.SERVER_URL + RequestService.POST_REGISTER, method: .post, parameters: registeruser, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            data -> Void in
            if data.result.isSuccess{
                print("register \(String(describing: data.value))")
                complete(data.value!)
            }
            
        })
    }
    
}
