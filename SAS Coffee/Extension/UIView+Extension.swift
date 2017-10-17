
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
    
    var NOTICE_VIEW_TAG : Int {
        return 201
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
        let holder : UIView = UIView.init(frame: self.frame)
        let blurview : UIVisualEffectView = UIVisualEffectView.init(frame : self.frame)
        blurview.effect = UIBlurEffect.init(style: .extraLight)
        self.addSubview(holder)
        holder.autoConstrainAttribute(.height, to: .height, of: self)
        holder.autoConstrainAttribute(.width, to: .width, of: self)
        holder.autoCenterInSuperview()
        holder.addSubview(blurview)
        blurview.autoConstrainAttribute(.height, to: .height, of: holder)
        blurview.autoConstrainAttribute(.width, to: .width, of: holder)
        blurview.autoCenterInSuperview()
        holder.tag = tag == nil ? BLURVIEW_TAG : tag!
        self.bringSubview(toFront: blurview)
        let logoview = UIImageView.init(image: logo)
        loadingView.center.x = self.frame.width/2.0
        holder.addSubview(logoview)
        holder.addSubview(loadingView)
        logoview.autoCenterInSuperview()
        
        loadingView.autoPinEdge(.top, to: .bottom, of: logoview)
        loadingView.autoPinEdge(.left, to: .left, of: logoview, withOffset: logoview.frame.width/2.0 - loadingView.frame.width/2.0)
        loadingView.startAnimating()
    }
    
    func stopLoading(loadingViewTag : Int?){
        self.viewWithTag( loadingViewTag != nil ? loadingViewTag! : BLURVIEW_TAG)?.removeFromSuperview()
    }
    
    func notice(icon: UIImage?, message: String!){
        let backgroundview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        backgroundview.backgroundColor = UIColor.white
        self.addSubview(backgroundview)
        backgroundview.autoConstrainAttribute(.height, to: .height, of: self)
        backgroundview.autoConstrainAttribute(.width, to: .width, of: self)
        backgroundview.autoCenterInSuperview()
        let viewholder = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 96.0, height: 192.0))
        backgroundview.addSubview(viewholder)
        backgroundview.tag = NOTICE_VIEW_TAG
        viewholder.autoSetDimension(.width, toSize: self.frame.width/3)
        viewholder.autoCenterInSuperview()
        let imagev : UIImageView!
        let messagelbl = UILabel.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 96.0, height: 96.0))
        messagelbl.text = message
        viewholder.addSubview(messagelbl)
        if let ic = icon {
            imagev =  UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 96.0, height: 96.0))
            imagev.image = icon?.changeTint(color: Style.colorWhiteHard)
            viewholder.addSubview(imagev)
            imagev.contentMode = .scaleToFill
            imagev.autoSetDimension(.height, toSize: self.frame.width/3.0)
            imagev.autoPinEdge(toSuperviewEdge: .top)
            imagev.autoPinEdge(toSuperviewEdge: .left)
            imagev.autoPinEdge(toSuperviewEdge: .right)
            messagelbl.autoPinEdge(.top, to: .bottom, of: imagev, withOffset: 16.0)
        }else{
            messagelbl.autoPinEdge(toSuperviewEdge: .top)
        }
        messagelbl.textColor = UIColor.lightGray
        messagelbl.numberOfLines = 0
        messagelbl.autoPinEdge(toSuperviewEdge: .bottom)
        messagelbl.center.x = self.frame.width/2.0
        messagelbl.textAlignment = .center
        messagelbl.autoSetDimension(.width, toSize: 128.0)
        messagelbl.autoPinEdge(toSuperviewEdge: .left)
        messagelbl.autoPinEdge(toSuperviewEdge: .right)
        
        
    }
    
    func unnotice(){
        self.viewWithTag(self.NOTICE_VIEW_TAG)?.removeFromSuperview()
    }
}
