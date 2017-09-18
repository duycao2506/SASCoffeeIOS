
//
//  UIView+Extension.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/3/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import PureLayout
import NVActivityIndicatorView

extension UIView {
    
    var BLURVIEW_TAG : Int {
        return 101
    }

    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
    
    //Require Purelayout and NVIndicatorView
    func startLoading(loadingView : NVActivityIndicatorView, logo : UIImage?, tag : Int?){
        let blurview : UIVisualEffectView = UIVisualEffectView.init(frame : self.frame)
        blurview.effect = UIBlurEffect.init(style: .extraLight)
        
        self.addSubview(blurview)
        blurview.autoConstrainAttribute(.height, to: .height, of: self)
        blurview.autoConstrainAttribute(.width, to: .width, of: self)
        blurview.autoCenterInSuperview()
        blurview.tag = tag == nil ? BLURVIEW_TAG : tag!
        self.bringSubview(toFront: blurview)
        let logoview = UIImageView.init(image: logo)
        loadingView.center.x = self.frame.width/2.0
        blurview.addSubview(logoview)
        blurview.addSubview(loadingView)
        logoview.autoCenterInSuperview()
        
        loadingView.autoPinEdge(.top, to: .bottom, of: logoview)
        loadingView.autoPinEdge(.left, to: .left, of: logoview, withOffset: logoview.frame.width/2.0 - loadingView.frame.width/2.0)
        loadingView.startAnimating()
    }
    
    func stopLoading(loadingViewTag : Int?){
        self.viewWithTag( loadingViewTag != nil ? loadingViewTag! : BLURVIEW_TAG)?.removeFromSuperview()
    }
}
