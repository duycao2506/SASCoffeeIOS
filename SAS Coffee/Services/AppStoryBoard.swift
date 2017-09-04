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
    case Main = "Main"
    case Login = "Login"
    case Map = "Map"
    case Menu = "Menu"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
