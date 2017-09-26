//
//  EventTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/10/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class EventTableViewCell: CardTableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var lbltitle: UILabel!
    //@IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDeadline: UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    
    var observer : KasperObserverDelegate! = nil
    var index : Int! = -1
    var promotion : PromotionModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateData(number : Int, str : String, obj : SuperModel){
        
    }
    
    override func updateData(anyObj : Any){
        self.promotion = anyObj as! PromotionModel
        self.lbltitle.text = self.promotion.name
        //self.lblDescription.text = self.promotion.descript
        self.lblDiscount.text = self.promotion.discount.description + "%"
    
        if (self.promotion.expireDate?.isAfter(date: Date(), granularity: Calendar.Component.day))! {
            self.lblDeadline.text = "Until".localize() + " " + (self.promotion.expireDate?.string(custom: "dd-MM-yyyy"))!
            self.lblDeadline.backgroundColor = UIColor.darkGray
            self.lblDeadline.textColor = Style.colorSecondary
            self.btnDelete.isHidden = true
        }else{
            self.lblDeadline.text = "Expired".localize()
            self.lblDeadline.backgroundColor = UIColor.red
            self.lblDeadline.textColor = UIColor.white
            self.btnDelete.isHidden = false
        }
    }

    @IBAction func press_btnClose(_ sender: Any){
        observer.callback(EventConst.PROMO_DELETE, true, index)
    }
}
