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
        self.tbView.spr_setIndicatorHeader {
            self.refreshData()
        }
        self.tbView.spr_beginRefreshing()
    }

    func refreshData(){
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
            self.tbView.spr_endRefreshing()
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
        let promo = self.promotionData[indexPath.row]
        if (promo.expireDate?.isBefore(date: Date.init(), granularity: Calendar.Component.day))! {
            notiTextview?.text = "The promotion has been expired already".localize()
            self.showNotification()
            DispatchQueue.global().async {
                sleep(2)
                DispatchQueue.main.async {
                    self.hideNotfication()
                }
            }
            return
        }
        let vc = AppStoryBoard.Promotion.instance.instantiateViewController(withIdentifier: VCIdentifiers.PromotionDetailVC.rawValue) as! PromotionDetailViewController
        vc.promotion = promo
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
        if code == nil {
            return
        }
        let codesure : Int = code!
        switch codesure {
        case EventConst.PROMO_DELETE:
            print("delete item number \(data as! Int)")
            let index = data as! Int
            
            RequestService.DELETE_promo( promoCode: self.promotionData[index].name, userId: AppSetting.sharedInstance().mainUser.id.description, complete: {
                data -> Void in
                let resp = data as! [String: Any]
                if resp["statuskey"] as! Bool {
                    
                }else{
                    self.tbView.spr_beginRefreshing()
                    self.notiTextview?.text = "Fail to delete promotion".localize()
                    self.showNotification()
                    DispatchQueue.global().async {
                        sleep(2)
                        DispatchQueue.main.sync {
                            self.hideNotfication()
                        }
                    }
                }
                
            })
            self.promotionData.remove(at: index)
            self.tbView.deleteRows(at: [IndexPath.init(row: index, section: 0)], with: UITableViewRowAnimation.fade)
            self.tbView.reloadData()
            break
        default:
            break
        }
        
    }
    
    

}
