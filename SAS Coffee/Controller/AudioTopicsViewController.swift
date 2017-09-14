//
//  AudioTopicsViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/9/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class AudioTopicsViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tbView.register(UINib.init(nibName: ViewNibNames.ivtitledescell, bundle: Bundle.main), forCellReuseIdentifier: TableViewCellIdetifier.icontitledesccell)
        self.tbView.estimatedRowHeight = 100
        self.tbView.rowHeight = UITableViewAutomaticDimension
        
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
        return tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.icontitledesccell)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppStoryBoard.Study.instance.instantiateViewController(withIdentifier: VCIdentifiers.AudioListVC.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
