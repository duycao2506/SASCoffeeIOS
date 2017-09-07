//
//  KasperObserverDelegate.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/6/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

protocol KasperObserverDelegate {
    func callback (_ code : Int?,_ succ : Bool?,_ data: Any)
}
