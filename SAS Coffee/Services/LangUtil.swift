//
//  LangUtil.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class LangUtil {

    private static var code : LangCode = LangCode.Default
    private static var langs : Dictionary = [
        LangCode.VN : [
            "loading" : "Đang xử lý...",
            "visit" : "Bạn đã ghé thăm",
            "times" : "lần"
        ],
        LangCode.EN : [
            "loading" : "Loading...",
            "visit" : "You have visited us",
            "times" : "times"
        ]
    ] as [LangCode : [String : String]]
    
    static func getString(key : String) -> String{
        if let dict = LangUtil.langs[LangUtil.code] {
            if let term = dict[key] {
                return term
            }else {
                return key
            }
        }
        return key
    }
    
    static func switchLang(code :LangCode){
        LangUtil.code = code
    }
}
