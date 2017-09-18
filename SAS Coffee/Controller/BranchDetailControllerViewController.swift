//
//  BranchDetailControllerViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/10/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import GradientView
import FontAwesomeKit

class BranchDetailController: KasperViewController {

    @IBOutlet weak var lblTitleBranch: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var btnDismiss: UIButton!
    
    @IBOutlet weak var btnCall: KasperButton!
    @IBOutlet weak var btnDirect: KasperButton!
    @IBOutlet weak var ivAddressBranch: UIImageView!
    @IBOutlet weak var ivTimeBranch: UIImageView!
    @IBOutlet weak var lblAddressBranch: UILabel!
    @IBOutlet weak var lbltimeBranch: UILabel!
    @IBOutlet weak var detailViewBottomConstraint: NSLayoutConstraint!
    
    
    var branch : BranchModel!
    
    func setupView(){
        self.btnDismiss.addTarget(self, action: #selector(BranchDetailController.press_dissmiss(_:)), for: .touchUpInside)
        self.view.layoutIfNeeded()
        detailViewBottomConstraint.constant = -detailView.frame.height - 100
        self.lblTitleBranch.text = branch.name
        self.ivTimeBranch.image = GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.timeIcon(withSize: 48.0)).changeTint(color: Style.colorPrimary)
        self.ivAddressBranch.image = GlobalUtils.getDefaultSizeImage(fakawe: FAKFontAwesome.mapMarkerIcon(withSize: 48.0)).changeTint(color: Style.colorPrimary)
        self.lbltimeBranch.text = branch.open
        self.lblAddressBranch.text = branch.address
        self.btnCall.setTitle("Contact".localize(), for: .normal)
        self.btnDirect.setTitle("Direct".localize(), for: .normal)
    }
    
    
    @IBAction func press_btnCall(_ sender: Any) {
        UIApplication.shared.open(URL.init(string: "telprompt://0909474232")!)
    }
    
    @IBAction func press_btnDirection(_ sender: Any) {
        UIApplication.shared.open(URL.init(string: "https://www.google.com/maps/place/\(self.branch.latitude),\(self.branch.longitude)")!)
    }
    func toggleBottom (completeFunc :  ((Bool)->())?) {
        
        var toVal : CGFloat = 0.0
        if detailViewBottomConstraint.constant == 0 {
            toVal = -detailView.frame.height
        }
        self.detailViewBottomConstraint.constant = toVal
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }, completion: completeFunc )
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        toggleBottom(completeFunc: nil)
    }
    
    func press_dissmiss(_ sender: Any)  {
        toggleBottom(completeFunc: {
            succ -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
