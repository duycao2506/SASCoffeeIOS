//
//  MenuViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import FontAwesomeKit
import DrawerController
import UIKit
import Firebase
import FirebaseMessaging
import GoogleSignIn
import ADAppRater

@objc
protocol MenuStrategy {
    func presentMenuAction()
}

class AbstractMenuStrategy : MenuStrategy {
    var menuVc : MenuViewController!
    init(menuVc : MenuViewController) {
        self.menuVc = menuVc
    }
    func presentMenuAction() {
        
    }
}

class MenuStrategyShowingViewController : AbstractMenuStrategy  {
    var desVc : UIViewController!
    init(menuVc : MenuViewController, desVc : UIViewController) {
        super.init(menuVc: menuVc)
        self.desVc = desVc
    }
    override func presentMenuAction() {
        let presentedVc = KasperNavViewController.init(rootViewController: desVc)
        self.customNavigationBarOf( desVc: presentedVc as! UINavigationController)
        menuVc.present(presentedVc, animated: true, completion: nil)
    }
    
    func customNavigationBarOf(desVc: UINavigationController) {
        let navbarFont = UIFont(name: "Roboto-Light", size: 21) ?? UIFont.systemFont(ofSize: 17)
        desVc.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.darkGray]
    }
}



class MenuStrategyRatingApp : AbstractMenuStrategy {
    override func presentMenuAction() {
        ADAppRater.sharedInstance().startFlow(from: self.menuVc)
    }
}

class MenuStrategySignOut : AbstractMenuStrategy {
    
    override func presentMenuAction() {
        let alert = UIAlertController(title: "Hmm".localize(), message: "Are you sure you want to sign out?".localize(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: {
            action -> Void in
            GIDSignIn.sharedInstance().signOut()
            Messaging.messaging().unsubscribe(fromTopic: AppSetting.sharedInstance().NOTI_ALL)
            Messaging.messaging().unsubscribe(fromTopic: AppSetting.sharedInstance().NOTI_BRANCH + AppSetting.sharedInstance().mainUser.branchId.description)
            RealmWrapper.remove(obj: AppSetting.sharedInstance().mainUser)
            self.menuVc.navigationController?.tabBarController?.dismiss(animated: true, completion: nil)
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel".localize(), style: UIAlertActionStyle.cancel, handler: {
            action -> Void in
            self.menuVc.tbView.selectRow(at: self.menuVc.selectedPath, animated: false, scrollPosition: .none)
            alert.dismiss(animated: true, completion: nil)
        }))
        menuVc.present(alert, animated: true, completion: nil)
    }
}

class MenuStrategyFeedback : MenuStrategy {
    func presentMenuAction() {
        let email = GlobalUtils.mail
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }
}




class MenuViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {

    
    var menuitems : [[Any]]!
    
    
    var vcIds : [[AppStoryBoard : VCIdentifiers]] = [
        [AppStoryBoard.Translation : VCIdentifiers.TranslatorVC],
        [AppStoryBoard.Study :  VCIdentifiers.StudyMethodVC],
        [AppStoryBoard.Web : VCIdentifiers.WebVC],
        [AppStoryBoard.Credit : VCIdentifiers.CreditVC]
    ]
    
    var menuStrategy : [MenuStrategy] = [MenuStrategy].init()
    
    var selectedPath : IndexPath? = nil
    
    @IBOutlet weak var tbView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuitems = [
            [
                GlobalUtils.getDefaultSizeImage(
                    fakmat: FAKMaterialIcons.translateIcon(withSize: 48.0)),
                "Translator".localize()
            ],
            [
                GlobalUtils.getDefaultSizeImage(
                    fakmat: FAKMaterialIcons.bookIcon(withSize: 48.0)),
                "Study with E4U".localize()
            ],
            [
                GlobalUtils.getDefaultSizeImage(
                    fakmat: FAKMaterialIcons.infoIcon(withSize: 48.0)),
                "About us".localize()
            ],
            [
                GlobalUtils.getDefaultSizeImage(
                    fakawe: FAKFontAwesome.creditCardIcon(withSize: 48.0)),
                "Credits".localize()
            ],
            [
                GlobalUtils.getDefaultSizeImage(
                    fakmat: FAKMaterialIcons.starIcon(withSize: 48.0)),
                "Rate now".localize()
            ],[
                GlobalUtils.getDefaultSizeImage(
                    fakawe: FAKFontAwesome.mailForwardIcon(withSize: 48.0)),
                "Feedback".localize()
            ],
            [
                GlobalUtils.getDefaultSizeImage(
                    fakawe: FAKFontAwesome.signOutIcon(withSize: 48.0)),
                "Sign out".localize()
            ]
        ]
        
        //Add menu strategies
        for i in vcIds {
            let tmpVC = i.keys.first?.instance.instantiateViewController(withIdentifier: (i.values.first?.rawValue)!) as! KasperViewController
            if tmpVC is WebViewController {
                (tmpVC as! WebViewController).url = Bundle.main.path(forResource: "info", ofType: "html")
            }
            let tmpStrategy = MenuStrategyShowingViewController.init(menuVc: self, desVc: tmpVC)
            menuStrategy.append(tmpStrategy)
        }
        menuStrategy.append(MenuStrategyRatingApp.init(menuVc: self))
        menuStrategy.append(MenuStrategyFeedback.init())
        menuStrategy.append(MenuStrategySignOut.init(menuVc: self))
        
        self.tbView.register(UINib.init(nibName: ViewNibNames.imageTitleCell, bundle: Bundle.main), forCellReuseIdentifier: TableViewCellIdetifier.iconTitleCell)
        self.tbView.contentInset = UIEdgeInsets.init(top: 24, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.iconTitleCell) as! ImageTitleTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.updateData(anyObj: menuitems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row < vcIds.count {
            self.selectedPath = indexPath
        }
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuStrategy[indexPath.row].presentMenuAction()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuitems.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
