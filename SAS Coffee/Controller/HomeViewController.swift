//
//  HomeViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import SwiftPullToRefresh
import FontAwesomeKit
import PopupDialog
import DrawerController
import Firebase
import FirebaseMessaging


class HomeViewController: KasperTableViewController {
    var arrProfile : [Any]!
    var hashCell : [String] = [
        TableViewCellIdetifier.basicInfoCell,
        TableViewCellIdetifier.pointCell,
        TableViewCellIdetifier.customerCodeCell,
        TableViewCellIdetifier.iconTitleCell
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: Prepare ui
        self.title = "Home".localize()
        
        
        arrProfile = [
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.emailIcon(withSize: 24.0)), AppSetting.sharedInstance().mainUser.email],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.calendarIcon(withSize: 24.0)), AppSetting.sharedInstance().mainUser.birthday == nil ? "Not available".localize() : AppSetting.sharedInstance().mainUser.birthday?.string(custom: "dd/MM/yyyy") as Any],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.phoneIcon(withSize: 24.0)), AppSetting.sharedInstance().mainUser.phone],
            [GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.mapIcon(withSize: 24.0)), AppSetting.sharedInstance().mainUser.address]]
        
        
        
        
        
        
        //MARK: TableView Configuration
        self.tbView.rowHeight = UITableViewAutomaticDimension
        self.tbView.register(UINib.init(nibName: ViewNibNames.imageTitleCell, bundle: Bundle.main), forCellReuseIdentifier: TableViewCellIdetifier.iconTitleCell)
        
        
        
        self.view.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo.png"), tag: nil)
        RequestService.GET_news(memberType: AppSetting.sharedInstance().mainUser.userType, complete: {
            news -> Void in
            self.view.stopLoading(loadingViewTag: nil)
            if news != nil {
                // Prepare the popup assets
                let title = "Message for you".localize()
                let message = news as! String
                let image = UIImage.init(named: "splash_news")
                
                // Create the dialog
                let popup = PopupDialog(title: title, message: message, image: image)
                popup.transitionStyle = .bounceDown
                
                // Create buttons
                
                let buttonOK = DefaultButton(title: "Got it".localize()) {
                    popup.dismiss()
                }
                buttonOK.titleLabel?.textColor = Style.colorSecondary
                
                // Add buttons to dialog
                // Alternatively, you can use popup.addButton(buttonOne)
                // to add a single button
                popup.addButton(buttonOK)
                
                // Present dialog
                self.present(popup, animated: true, completion: nil)
            }
        })
        
        Messaging.messaging().subscribe(toTopic: AppSetting.sharedInstance().NOTI_ALL)
        Messaging.messaging().subscribe(toTopic: AppSetting.sharedInstance().NOTI_BRANCH
             + AppSetting.sharedInstance().mainUser.branchId.description)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
    }
    
    
    
    
    override func refreshData(){
        RequestService.GET_login(endpoint: RequestService.GET_LOGIN_AUTO, token: AppSetting.sharedInstance().mainUser.token.toBase64(), complete: {
            data -> Void in
            DataService.assignUser(response: data as! [String : Any], vc: self)
            RealmWrapper.save(obj: AppSetting.sharedInstance().mainUser)
            self.tbView.spr_endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /**
    * Table view func
    */
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : SuperTableViewCell? = self.tbView.dequeueReusableCell(withIdentifier: hashCell[indexPath.row < 3 ? indexPath.row : 3]) as! SuperTableViewCell
        if cell is ImageTitleTableViewCell {
            cell?.updateData(anyObj: arrProfile[indexPath.row-3])
        }else{
            cell?.updateData(number: 0, str: "", obj: AppSetting.sharedInstance().mainUser)
        }
        return cell!
    }
    
    
}
