//
//  PromotionJoinViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/16/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class PromotionJoinViewController: KasperViewController {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnOk: KasperButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var tfPhone: UITextField!
    
    var detailVC : PromotionDetailViewController!
    var eventid : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        maxheightnoti = 56
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tfName.text = AppSetting.sharedInstance().mainUser.name
        print(AppSetting.sharedInstance().mainUser.name)
        let phone = AppSetting.sharedInstance().mainUser.phone
        self.tfPhone.text = (phone == "Not available" ? "" : phone)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func press_btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func press_btnOk(_ sender: Any) {
        if (tfName.text?.isEmpty)! || (tfPhone.text?.isEmpty)! {
            notiTextview?.text = "Please input all fields below".localize()
            showNotification()
            return
        }
        hideNotfication()
        self.viewMain.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo"), tag: nil)
        RequestService.POST_join_event(eventId: eventid, userId: AppSetting.sharedInstance().mainUser.id.description, userName: tfName.text!, phone: tfPhone.text!, complete: {
            data -> Void in
            let response = data as! [String : Any]
            print(response)
            if response["statuskey"] as! Bool {
                self.dismiss(animated: true, completion: {
                    self.detailVC.btnJoin.isEnabled = false
                    self.detailVC.btnJoin.normalBackground = UIColor.gray
                })
            }else{
                self.notiTextview?.text = response["message"] as! String
                self.showNotification()
            }
            self.viewMain.stopLoading(loadingViewTag: nil)
            
            
            
        })
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
