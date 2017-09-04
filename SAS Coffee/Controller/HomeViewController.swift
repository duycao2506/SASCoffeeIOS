//
//  HomeViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/1/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import FontAwesomeKit

class HomeViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbview : UITableView!
    
    
    
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
        
        arrProfile = [
            [GlobalUtils.getDefaultSizeImage(fak: FAKMaterialIcons.emailIcon(withSize: 24.0)), AppSetting.sharedInstance().mainUser.email],
            [GlobalUtils.getDefaultSizeImage(fak: FAKMaterialIcons.calendarIcon(withSize: 24.0)), AppSetting.sharedInstance().mainUser.birthday.string(custom: "dd/MM/yyyy")],
            [GlobalUtils.getDefaultSizeImage(fak: FAKMaterialIcons.phoneIcon(withSize: 24.0)), AppSetting.sharedInstance().mainUser.phone],
            [GlobalUtils.getDefaultSizeImage(fak: FAKMaterialIcons.mapIcon(withSize: 24.0)), AppSetting.sharedInstance().mainUser.address]]
        
        
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.startAnimating()
            sleep(4)
            DispatchQueue.main.async {
                self.stopAnimating()
            }
        }
        
        //MARK: TableView Configuration
        tbview.rowHeight = UITableViewAutomaticDimension
        tbview.register(UINib.init(nibName: ViewNibNames.imageTitleCell, bundle: Bundle.main), forCellReuseIdentifier: TableViewCellIdetifier.iconTitleCell)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : SuperTableViewCell? = tbview.dequeueReusableCell(withIdentifier: hashCell[indexPath.row < 3 ? indexPath.row : 3]) as! SuperTableViewCell
        if cell is ImageTitleTableViewCell {
            cell?.updateData(anyObj: arrProfile[indexPath.row-3])
        }else{
            cell?.updateData(number: 0, str: "", obj: AppSetting.sharedInstance().mainUser)
        }
        return cell!
    }
}
