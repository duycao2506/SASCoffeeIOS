//
//  AudioTopicsViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/9/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class AudioTopicsViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {

    
    var topics : [TopicModel] = [TopicModel].init()
    let topicImages : [String: [String]] = [
        "heal" : ["health", "hospital"],
        "shop" : ["shop", "supermarket"],
        "workplace" : ["work", "office"],
        "job" : ["job", "interview"],
        "daily" : ["daily", "routine", "life"],
        "dating" : ["dating", "love"],
        "note" : ["default", "note"],
        "hotel" : ["hotel", "motel", "sleep"],
        "eat" : ["restaurant", "eat", "meal", "eat"],
        "drink" : ["drink", "coffee", "tea"],
        "direction" : ["street", "sign", "traffic","direction"]
    ]
    
    @IBOutlet var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tbView.register(UINib.init(nibName: ViewNibNames.ivtitledescell, bundle: Bundle.main), forCellReuseIdentifier: TableViewCellIdetifier.icontitledesccell)
        self.tbView.estimatedRowHeight = 100
        self.tbView.rowHeight = UITableViewAutomaticDimension
        self.tbView.spr_setTextHeader {
            RequestService.GET_all_topic(complete: {
                data -> Void in
                let resp = data as! [String : Any]
                if resp["statuskey"] as! Bool {
                    let topArray = resp["data"] as! [[String:Any]]
                    self.topics = DataService.parseTopics(resp: topArray)
                    print(resp["data"])
                }else{
                    
                }
                self.tbView.reloadData()
                self.tbView.spr_endRefreshing()
                
            })
        }
        self.tbView.spr_beginRefreshing()
        
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
        let cell = tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.icontitledesccell)! as! IvLblDesTableViewCell
        let topic = topics[indexPath.row]
        var strImg : String = "note"
        _ = topicImages.index(where: {
            key, valArr -> Bool in
            if valArr.index(where: {
                valStri -> Bool in
                let topicname = topics[indexPath.row].name
                return topicname.lowercased().contains(valStri)
            }) != nil {
                strImg = key
                return true
            }
            return false
        })
        cell.ivicon.image = UIImage.init(named: strImg)!
        cell.lblTitle.text = topic.name
        cell.lbldesc.text = topic.nameVi
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppStoryBoard.Study.instance.instantiateViewController(withIdentifier: VCIdentifiers.AudioListVC.rawValue) as! AudioListViewController
        vc.sentences = topics[indexPath.row].sentenceList
        vc.navigationItem.title = topics[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
