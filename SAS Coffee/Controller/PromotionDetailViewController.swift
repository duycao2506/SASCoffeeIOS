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
    
    
    @IBOutlet weak var btnJoin: KasperButton!
    
    var promotion : PromotionModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        lblTitle.text = promotion.name
        lblDeadline.text = "Until".localize() + " " + (promotion.expireDate?.string(custom: "dd-MM-yyyy"))!
        lblDiscount.text = promotion.discount.description + "%"
        var rawString = ""
        if let promotionCor = promotion as? PromoEventModel {
            rawString = promotionCor.fullDes
        }else{
            rawString = promotion.descript
        }
        let attstring : NSAttributedString =  try! NSAttributedString.init(data: rawString.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        tvDesc.attributedText = attstring
        checkJoin()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func checkJoin(){
        self.view.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo"), tag: nil)
        RequestService.GET_memberList(promoId: promotion.id.description, complete: {
            response -> Void in
            let res = response as! [String : Any]
            print(res)
            if res["statuskey"] as! Bool {
                    let members = res["members"] as! [Any]
                if members.index(where: {
                    item -> Bool in
                    if !(item is NSNull){
                        let i = item as! [String : Any]
                        return (i["id"] as! Int) == AppSetting.sharedInstance().mainUser.id
                    }
                    return false
                }) != nil{
                        self.btnJoin.normalBackground = UIColor.gray
                        self.btnJoin.isEnabled = false
                        self.btnJoin.setTitle("JOINED".localize(), for: .disabled)
                    }
            }
            self.view.stopLoading(loadingViewTag: nil)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func press_btnJoin(_ sender: Any) {
        let joinvc = AppStoryBoard.Promotion.instance.instantiateViewController(withIdentifier: VCIdentifiers.PromotionJoinConfirmVC.rawValue) as! PromotionJoinViewController
        joinvc.eventid = self.promotion.id.description
        joinvc.detailVC = self
        joinvc.modalTransitionStyle = .crossDissolve
        joinvc.modalPresentationStyle = .overCurrentContext
        joinvc.modalPresentationCapturesStatusBarAppearance = true
        self.present(joinvc, animated: true, completion: nil)
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
