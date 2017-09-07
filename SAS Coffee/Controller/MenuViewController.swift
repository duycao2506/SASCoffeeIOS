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



class MenuViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {

    
    var menuitems : [[Any]]!
    var vcArray : [KasperViewController] = [KasperViewController]()
    
    @IBOutlet weak var tbView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuitems = [
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.homeIcon(withSize: 48.0)), "Home".localize()],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.starIcon(withSize: 48.0)), "Promotion".localize()],
            [GlobalUtils.getDefaultSizeImage(fakawe: FAKFontAwesome.mapMarkerIcon(withSize: 48.0)),"Shop".localize()],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.translateIcon(withSize: 48.0)), "Translator".localize()],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.bookIcon(withSize: 48.0)),"Study with E4U".localize()],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.infoIcon(withSize: 48.0)), "About us".localize()],
            [GlobalUtils.getDefaultSizeImage(fakawe: FAKFontAwesome.signOutIcon(withSize: 48.0)),"Sign out".localize()]
        ]
        
        vcArray.append(AppStoryBoard.Promotion.instance.instantiateViewController(withIdentifier: VCIdentifiers.PromotionVC.rawValue) as! KasperViewController)
        vcArray.append(AppStoryBoard.Map.instance.instantiateViewController(withIdentifier: VCIdentifiers.MapViewController.rawValue) as! KasperViewController)
        vcArray.append(AppStoryBoard.Study.instance.instantiateViewController(withIdentifier: VCIdentifiers.StudyMethodVC.rawValue) as! KasperViewController)
        vcArray.append(AppStoryBoard.Translation.instance.instantiateViewController(withIdentifier: VCIdentifiers.TranslatorVC.rawValue) as! KasperViewController)
        vcArray.append(AppStoryBoard.Web.instance.instantiateViewController(withIdentifier: VCIdentifiers.WebVC.rawValue) as! KasperViewController)

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(menuitems[indexPath.row][1] as! String)
        let centernav = self.evo_drawerController?.centerViewController as! HomeNavViewController
        centernav.setViewControllers([vcArray[indexPath.row]], animated: true)
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
