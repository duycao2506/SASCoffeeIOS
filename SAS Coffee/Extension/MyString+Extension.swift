//
//  MyString+Extension.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

extension String {
    func localize() -> String
    {
        return LangUtil.getString(key: self)
    }
}
