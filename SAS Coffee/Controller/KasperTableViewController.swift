//
//  KasperTableViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 10/27/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class KasperTableViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tbView : UITableView!
    var page : Int = 0
    var sizeOfPage : Int = 10
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbView.spr_setIndicatorHeader {
            self.refreshData()
        }
        self.tbView.spr_setIndicatorFooter {
            self.loadMore()
        }
        self.tbView.spr_beginRefreshing()
        // Do any additional setup after loading the view.
    }
    
    func refreshData(){
        self.tbView.spr_endRefreshing()
    }
    
    func loadMore(){
       self.tbView.spr_endRefreshing()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    

}
