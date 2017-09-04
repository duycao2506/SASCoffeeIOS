//
//  CustomerCodeTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/2/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import PureLayout

class CustomerCodeTableViewCell: CardTableViewCell {

    @IBOutlet weak var lblCode : UILabel!
    @IBOutlet weak var lblCheckin : UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func updateData(number: Int, str: String, obj: SuperModel) {
        let user = obj as! UserModel
        lblCode.text = user.userCode
        lblCheckin.text = "visit".localize() + " \(user.checkIntime.description) " + "times".localize()
    }
    
}
