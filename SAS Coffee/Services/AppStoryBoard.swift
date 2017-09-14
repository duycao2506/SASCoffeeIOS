//
//  AppStoryBoard.swift
//  SAS Coffee
//
//  Created by Duy Cao on 8/30/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

enum AppStoryBoard : String {
    case Home = "Home"
    case Login = "Login"
    case Map = "Map"
    case Menu = "Menu"
    case Study = "Study"
    case Translation = "Translation"
    case Promotion = "Promotion"
    case Web = "Web"
    case Credit = "Credits"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
