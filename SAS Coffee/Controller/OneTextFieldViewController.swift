//
//  OneTextFieldViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/5/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

enum InputType {
    case email
    case password
    case confirmPassword
}

class OneTextFieldViewController: KasperViewController {

    @IBOutlet weak var lblOneTfDescript: UILabel!
    
    @IBOutlet weak var txtMain: UITextField!
    
    var strDesc : String!
    var strPlaceholder : String!
    var dataKey : String?
    var strTitle : String!
    var previousData : [String: String]!
    var isSecured: Bool! = false
    var continueNextVC : (([String : String], KasperNavViewController) -> ())!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func setupViews(){
        self.notiTextview?.text = "Invalid" + " " + strTitle
        lblOneTfDescript.text = strDesc
        txtMain.placeholder = strPlaceholder
        txtMain.isSecureTextEntry = isSecured
        self.navigationItem.title = strTitle
        self.txtMain.attributedPlaceholder = NSAttributedString(string: strPlaceholder,
                                                                attributes: [NSForegroundColorAttributeName: Style.colorWhiteHard])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.notiViewHeightConstraint?.constant = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func continueOneText(_ sender: Any) {
        if continueCondition!(previousData, txtMain.text) {
            if dataKey != nil {
                previousData[dataKey!] = txtMain.text
            }
            continueNextVC(self.previousData, self.navigationController! as! KasperNavViewController)
        }else
        {
            showNotification()
        }
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
