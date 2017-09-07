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
            "emailDesc":"Email của bạn giúp chúng tôi xác định được bạn là ai",
            "email_screen_title":"Nhập email",
            "email":"Email của bạn là gì?",
            "passwordDesc":"Một chuỗi các ký tự bảo vệ tài khoản của bạn. Độ dài phải lớn hơn 6 ký tự",
            "password":"Mật khẩu",
            "passwordConfDesc":"Bạn chưa đăng ký, để đảm bảo bạn không gõ nhầm mật khẩu, bạn vui lòng nhập mật khẩu một lần nữa nhé.",
            "confirmPass":"Xác nhận mật khẩu",
            "times" : "lần"
        ],
        LangCode.EN : [
            "loading" : "Loading...",
            "visit" : "You have visited us",
            "emailDesc":"Your email helps us identify who you are.",
            "email_screen_title":"Email Input",
            "email":"What your email is",
            "passwordDesc":"A secured string that protect your account. Its length must be more than 6 characters",
            "password":"Password",
            "passwordConfDesc":"You have not registered yet. To ensure that there is no mistake in the password you have typed, please input your password one more time",
            "confirmPass":"Confirm your password",
            "times" : "times"
        ]
    ] as [LangCode : [String : String]]
    
    static func getString(key : String) -> String{
        if let dict = LangUtil.langs[LangUtil.code] {
            if let term = dict[key] {
                return term
            }else {
                let str : String = "\"\(key)\":\"\(key)\","
                print(str)
                return key
            }
        }
        let str : String = "\"\(key)\":\"\(key)\""
        print(str)
        return key
    }
    
    static func switchLang(code :LangCode){
        LangUtil.code = code
    }
}
