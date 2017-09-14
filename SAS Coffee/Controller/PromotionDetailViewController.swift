//
//  PromotionDetailViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/13/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class PromotionDetailViewController: KasperViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDeadline: UILabel!
    @IBOutlet weak var tvDesc: UITextView!
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}
