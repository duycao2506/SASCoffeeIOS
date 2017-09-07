//
//  KasperViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 8/30/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class KasperViewController: UIViewController, NVActivityIndicatorViewable, KasperObserverDelegate {

    var activityData : ActivityData!
    var backcomplete : (() -> Void)?
    var continueCondition : ((Any, Any) -> Bool)?
    @IBOutlet weak var notiViewHeightConstraint : NSLayoutConstraint?
    @IBOutlet weak var notiTextview : UILabel?
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
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
    
    @IBAction func actionBack (_sender: Any){
        if let nav = self.navigationController {
            if nav.viewControllers.first != self {
                self.navigationController?.popViewController(animated: true)
            }
        }
        dismiss(animated: true, completion: backcomplete)
    }

    
    func showNotification(){
        if self.notiViewHeightConstraint != nil {
            self.view.layoutIfNeeded()
            self.notiViewHeightConstraint?.constant = 36
            UIView.animate(withDuration: 0.4, animations: {
                self.view.layoutIfNeeded() 
            })
        }
    }
    
    func callback(_ code: Int?, _ succ: Bool?, _ data: Any) {
        
    }
}
