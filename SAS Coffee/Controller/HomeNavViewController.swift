//
//  HomeViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 8/30/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

import DrawerController

class HomeNavViewController: KasperNavViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewControllers.first?.navigationItem.leftBarButtonItems?.first?.action = Selector.init(("toggleNav:"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func toggleNav(_ sender: Any){
        self.evo_drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
    }
    
    func openFace(_ sender: Any){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: "https://www.facebook.com/SaiGonAmericanEnglish/")!)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(URL.init(string: "https://www.facebook.com/SaiGonAmericanEnglish/")!)
        }
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: true)
        self.viewControllers.first?.navigationItem.leftBarButtonItems?.first?.action = #selector(HomeNavViewController.toggleNav(_:))
        self.viewControllers.first?.navigationItem.rightBarButtonItems?.first?.action = #selector(HomeNavViewController.openFace(_:))
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
