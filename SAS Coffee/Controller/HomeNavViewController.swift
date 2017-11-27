//
//  HomeViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 8/30/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

import DrawerController

class HomeNavViewController: KasperNavViewController {

    
    static var NOTIFICATION_DATA : [String : Any] = [
        "eventId" : -1,
        "newsId" : -1
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewControllers.first?.navigationItem.leftBarButtonItems?.first?.action = #selector(HomeNavViewController.toggleNav(_:))
        NotificationCenter.default.addObserver(self, selector: #selector(self.remoteNotiEvent(notification:)), name:
            NSNotification.Name(rawValue: EventConst.REMOTE_NOTI), object: nil)
    }
    
    
    func remoteNotiEvent(notification : Notification){
        if let eventId = notification.userInfo!["id"],  (eventId as! NSString).integerValue > -1 {
            self.view.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo"), tag: 111)
            RequestService.GET_promo_by(userId: AppSetting.sharedInstance().mainUser.id.description, complete: { (data) in
                let resp = data as! [String : Any]
                let succ = resp["statuskey"] as! Bool
                if succ {
                    let response = resp["promoList"] as! [[String:Any]]
                    if let event = DataService.findEventByIdInPromotionList(id : (eventId as! NSString).integerValue, promotelistRaw: response)
                    {
                        let vc = AppStoryBoard.Promotion.instance.instantiateViewController(withIdentifier: VCIdentifiers.PromotionDetailVC.rawValue) as! PromotionDetailViewController
                        vc.promotion = event
                        self.present(vc, animated: true, completion: nil)
                        HomeNavViewController.NOTIFICATION_DATA["eventId"] = -1
                    }
                }
                self.view.stopLoading(loadingViewTag: 111)
                
            })
        }
    }
    
//    func remoteNotiNews(notification : Notification){
//        if let eventId = notification.userInfo!["id"],  (eventId as! NSString).integerValue > -1 {
//            self.view.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo"), tag: 111)
//            RequestService. (userId: AppSetting.sharedInstance().mainUser.id.description, complete: { (data) in
//                let resp = data as! [String : Any]
//                let succ = resp["statuskey"] as! Bool
//                if succ {
//                    let response = resp["newsList"] as! [[String:Any]]
//                    let event = DataService.findEventByIdInPromotionList(id : (eventId as! NSString).integerValue, promotelistRaw: response)
//                    let vc = AppStoryBoard.Promotion.instance.instantiateViewController(withIdentifier: VCIdentifiers.rawValue) as! PromotionDetailViewController
//                    vc.promotion = event
//                    self.present(vc, animated: true, completion: nil)
//                    HomeNavViewController.NOTIFICATION_DATA["newsId"] = -1
//                }
//                self.view.stopLoading(loadingViewTag: 111)
//
//            })
//        }
//    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func toggleNav(_ sender: Any){
        self.evo_drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
    }
    
    func openFace(_ sender: Any){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: "https://www.facebook.com/SaiGonAmericanEnglish/")!)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(URL.init(string: "https://www.facebook.com/SaiGonAmericanEnglish/")!)
        }
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: true)
        self.viewControllers.first?.navigationItem.leftBarButtonItems?.first?.action = #selector(HomeNavViewController.toggleNav(_:))
        self.viewControllers.first?.navigationItem.rightBarButtonItems?.first?.action = #selector(HomeNavViewController.openFace(_:))
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
