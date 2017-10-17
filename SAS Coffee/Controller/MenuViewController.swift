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
import GoogleSignIn




class MenuViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {

    
    var menuitems : [[Any]]!
    var vcArray : [KasperViewController] = [KasperViewController]()
    
    var selectedPath : IndexPath? = nil
    
    @IBOutlet weak var tbView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuitems = [
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.homeIcon(withSize: 48.0)), "Home".localize()],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.starIcon(withSize: 48.0)), "Event(s)".localize()],
            [GlobalUtils.getDefaultSizeImage(fakawe: FAKFontAwesome.mapMarkerIcon(withSize: 48.0)),"SAS Coffee Towns".localize()],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.translateIcon(withSize: 48.0)), "Translator".localize()],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.bookIcon(withSize: 48.0)),"Study with E4U".localize()],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.infoIcon(withSize: 48.0)), "About us".localize()],
            [GlobalUtils.getDefaultSizeImage(fakawe: FAKFontAwesome.creditCardIcon(withSize: 48.0)), "Credits".localize()],
            [GlobalUtils.getDefaultSizeImage(fakawe: FAKFontAwesome.signOutIcon(withSize: 48.0)),"Sign out".localize()]
        ]
        
        let aboutusresPath = Bundle.main.path(forResource: "info", ofType: "html")
        let aboutusvc = AppStoryBoard.Web.instance.instantiateViewController(withIdentifier: VCIdentifiers.WebVC.rawValue) as! WebViewController
        aboutusvc.url = aboutusresPath
        vcArray.append(AppStoryBoard.Promotion.instance.instantiateViewController(withIdentifier: VCIdentifiers.PromotionVC.rawValue) as! KasperViewController)
        vcArray.append(AppStoryBoard.Map.instance.instantiateViewController(withIdentifier: VCIdentifiers.MapViewController.rawValue) as! KasperViewController)
        vcArray.append(AppStoryBoard.Translation.instance.instantiateViewController(withIdentifier: VCIdentifiers.TranslatorVC.rawValue) as! KasperViewController)
        vcArray.append(AppStoryBoard.Study.instance.instantiateViewController(withIdentifier: VCIdentifiers.StudyMethodVC.rawValue) as! KasperViewController)
        vcArray.append(aboutusvc)
        vcArray.append(AppStoryBoard.Credit.instance.instantiateViewController(withIdentifier: VCIdentifiers.CreditVC.rawValue) as! KasperViewController)

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
        if indexPath.row < vcArray.count {
            self.selectedPath = indexPath
        }
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < vcArray.count {
            let centernav = self.evo_drawerController?.centerViewController as! HomeNavViewController
            let chosenVc = vcArray[indexPath.row]
            chosenVc.navigationItem.title = menuitems[indexPath.row][1] as? String
            centernav.setViewControllers([chosenVc], animated: true)
        }else{
            let alert = UIAlertController(title: "Hmm".localize(), message: "Are you sure you want to sign out?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: {
                action -> Void in
                GIDSignIn.sharedInstance().signOut()
                RealmWrapper.remove(obj: AppSetting.sharedInstance().mainUser)
                Messaging.messaging().unsubscribe(fromTopic: "allUser")
                self.evo_drawerController?.dismiss(animated: true, completion: nil)
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction.init(title: "Cancel".localize(), style: UIAlertActionStyle.cancel, handler: {
                action -> Void in
                self.tbView.selectRow(at: self.selectedPath, animated: false, scrollPosition: .none)
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        self.evo_drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
        
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
