//
//  CreditViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/10/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class CreditViewController: KasperViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbView : UITableView!

    let images : [UIImage] = [#imageLiteral(resourceName: "freepik"), UIImage.init(named: "smashicons")!]
    let strs : [String] = ["Freepik", "Smashicons"]
    let links : [String]  = ["http://www.freepik.com/", "https://smashicons.com/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbView.register(UINib.init(nibName: ViewNibNames.ivtitledescell, bundle: Bundle.main), forCellReuseIdentifier: TableViewCellIdetifier.icontitledesccell)

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.icontitledesccell) as! IvLblDesTableViewCell
//        cell.isCardView = false
        cell.lbldesc.text = links[indexPath.row]
        cell.lblTitle.text = strs[indexPath.row]
        cell.ivicon.image = images[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }

}
