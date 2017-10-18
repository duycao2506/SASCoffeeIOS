//
//  OptionalInfoViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/5/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import ObjectMapper

class OptionalInfoViewController: KasperViewController {

    
    @IBOutlet weak var lbloptionaDesc: UILabel!
    @IBOutlet weak var txtBirthday: UITextField!
    
    @IBOutlet weak var txtAddress: UITextField!
    
    var data : [String : Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbloptionaDesc.text = "optional_info_desc".localize()
        txtBirthday.attributedPlaceholder =  NSAttributedString(string: "your_birthday".localize(),
                                                                attributes: [NSForegroundColorAttributeName: Style.colorWhiteHard])
        txtAddress.attributedPlaceholder =  NSAttributedString(string: "your_address".localize(),
                                                     attributes: [NSForegroundColorAttributeName: Style.colorWhiteHard])
        self.navigationItem.title = "optional_info_title".localize()
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        txtBirthday.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)


        // Do any additional setup after loading the view.
    }

    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        
        txtBirthday.text = sender.date.string(custom: "dd/MM/yyyy")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func finishRegister () {
        data[UserModel.ADDRESS] = txtAddress.text
        var birthdate = Date.init()
        if (txtBirthday.text?.isEmpty)! {
            data[UserModel.BIRTHDAY] = birthdate.string(custom: "dd-MM-yyyy")
        }else{
            birthdate = (txtBirthday.text?.toDate("dd/MM/yyyy"))!
            data[UserModel.BIRTHDAY] =  txtBirthday.text
        }
        
        
        var newuser : UserModel = UserModel.init()
        newuser.mapping(map: Map.init(mappingType: .fromJSON, JSON: self.data))
        newuser.birthday = birthdate
        
        
        self.navigationController?.view.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo.png"), tag: nil)
        print(newuser)
        RequestService.POST_register(user: newuser, complete: {
            data -> Void in
            let resp = data as! [String : Any ]
            print(resp)
            if DataService.assignUser(response: resp, vc: self) {
                self.dismiss(animated: true, completion: {
                    (self.navigationController as! LoginNavViewController).caller.callback(EventConst.REGISTER_SUCCESS, true, self.data)
                })
            }
            self.navigationController?.view.stopLoading(loadingViewTag: nil)
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
