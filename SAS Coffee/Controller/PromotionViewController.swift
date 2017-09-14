//
//  PromotionViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class PromotionViewController: KasperViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tbView : UITableView!
    
    var promotionData : [PromotionModel] = [PromotionModel]()
    
    
    var testArr : [String] = ["dsadsa","d21412rwq", "ewqrwq21412", "4214wqrwqrqw", "421421rwqrwq", "421421rwqrqw"]
    var size : Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        RequestService.GET_promo_by(userId: AppSetting.sharedInstance().mainUser.id.description, complete: {
            data -> Void in
            let resp = data as! [String : Any]
            let succ = resp["statuskey"] as! Bool
            if succ {
                let response = resp["promoList"] as! [[String:Any]]
                self.promotionData = DataService.parsePromotionList(response: response)
                print(self.promotionData)
                self.tbView.reloadData()
            }else{
                self.notiTextview?.text = "Fail to fetch the list of promotions".localize()
                self.showNotification()
            }
        })
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppStoryBoard.Promotion.instance.instantiateViewController(withIdentifier: VCIdentifiers.PromotionDetailVC.rawValue)
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  self.tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.promotionCell)! as! EventTableViewCell
        cell.index = indexPath.row
        cell.observer = self
        cell.updateData(anyObj: promotionData[indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotionData.count
    }
    
    override func callback(_ code: Int?, _ succ: Bool?, _ data: Any) {
        print("delete item number \(data as! Int)")
        self.promotionData.remove(at: data as! Int)
        self.tbView.deleteRows(at: [IndexPath.init(row: data as! Int, section: 0)], with: UITableViewRowAnimation.fade)
        self.tbView.reloadData()
    }
    
    

}
