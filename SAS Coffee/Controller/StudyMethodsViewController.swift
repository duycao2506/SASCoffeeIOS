//
//  StudyMethodsViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class StudyMethodsViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbView : UITableView!
    
    let images : [UIImage] = [UIImage.init(named: "headphones")!, UIImage.init(named: "video-player")!]
    let strs : [String] = ["Short Talks".localize(), "Video clips".localize()]
    let vcIdentifiers : [String] = [VCIdentifiers.AudioTopicsVC.rawValue, VCIdentifiers.VideoListVC.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Study with E4U".localize()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.studymethodcell) as! StudyMethodTableCell
        cell.ivIcon.image = images[indexPath.row]
        cell.lblTitle.text = strs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppStoryBoard.Study.instance.instantiateViewController(withIdentifier: vcIdentifiers[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    

}
