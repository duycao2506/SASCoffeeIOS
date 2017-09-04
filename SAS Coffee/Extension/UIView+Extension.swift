
//
//  UIView+Extension.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/3/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

extension UIView {

    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
}
