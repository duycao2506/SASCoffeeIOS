//
//  TranslationViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TranslationViewController: KasperViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnSpeak: UIButton!
    @IBOutlet weak var txtTranslate: UITextField!
    @IBOutlet weak var btnTranslate: KasperButton!
    @IBOutlet weak var topCardView: UIView!
    
    @IBOutlet weak var tbViewTr: UITableView!
    
    
    var haveData : Bool! = false
    
    
    func setupView(){
        btnSpeak.setImage(btnSpeak.image(for: .normal)?.changeTint(color: Style.colorPrimary), for: .normal)
        btnSpeak.addTarget(self, action: #selector(TranslationViewController.press_btnTranslate(_:)), for: .touchUpInside)
        self.topCardView.layer.shadowPath = UIBezierPath.init(rect: self.topCardView.bounds).cgPath
        self.topCardView.layer.masksToBounds = false
        self.topCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.topCardView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.topCardView.layer.shadowOpacity = 0.8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func press_btnTranslate(_ sender: Any) {
        print("hello")
        self.startAnimating()
        DispatchQueue.global().async {
            sleep(3)
            self.haveData = true
            DispatchQueue.main.sync {
                self.tbViewTr.reloadData()
                self.stopAnimating()
            }
        }
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.haveData {
            return 10
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tbViewTr.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.meaningCell)!
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
