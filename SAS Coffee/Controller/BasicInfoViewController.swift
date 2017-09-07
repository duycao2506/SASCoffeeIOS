//
//  BasicInfoViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/5/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class BasicInfoViewController: KasperViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var lblDesc: UILabel!
    
    var data : [String:String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "basic_info_title".localize()
        lblDesc.text = "basic_info_desc".localize()
        self.notiTextview?.text = "required_fields".localize()
        txtName.attributedPlaceholder = NSAttributedString(string: "what your name is".localize(),
                                                           attributes: [NSForegroundColorAttributeName: Style.colorWhiteHard])
        txtPhone.attributedPlaceholder = NSAttributedString(string: "what your phone is".localize(),
                                                            attributes: [NSForegroundColorAttributeName: Style.colorWhiteHard])
        //These required information will help us inform you the latest promotions and offers in time as well as enhance your account security
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionToOptional(_ sender: Any) {
        if txtName.text?.length == 0 || txtPhone.text?.length == 0 {
            showNotification()
            return
        }        
        data[UserModel.PHONE] = txtPhone.text
        data[UserModel.NAME] = txtName.text
        let optionaVC = AppStoryBoard.Login.instance.instantiateViewController(withIdentifier: VCIdentifiers.OptionalInfoVC.rawValue) as! OptionalInfoViewController
        optionaVC.data = self.data
        self.navigationController?.pushViewController(optionaVC, animated: true)
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
