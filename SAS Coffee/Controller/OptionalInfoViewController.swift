//
//  OptionalInfoViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/5/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class OptionalInfoViewController: KasperViewController {

    
    @IBOutlet weak var lbloptionaDesc: UILabel!
    @IBOutlet weak var txtBirthday: UITextField!
    
    @IBOutlet weak var txtAddress: UITextField!
    
    var data : [String : String]!
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
        data[UserModel.BIRTHDAY] = txtBirthday.text
        dismiss(animated: true, completion: {
            (self.navigationController as! LoginNavViewController).caller.callback(1, true, self.data)
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
