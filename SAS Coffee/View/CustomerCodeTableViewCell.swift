//
//  CustomerCodeTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/2/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import PureLayout
import FBSDKLoginKit
import FBSDKShareKit

class CustomerCodeTableViewCell: CardTableViewCell {

    @IBOutlet weak var lblCode : UILabel!
    @IBOutlet weak var lblCheckin : UILabel!

    
    @IBOutlet weak var btnLike: FBSDKLikeButton!
    @IBOutlet weak var btnShare: FBSDKShareButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    override func updateData(number: Int, str: String, obj: SuperModel) {
        btnLike.objectID = "https://www.facebook.com/english4ucoffeeclub/"
        let linkShareContent = FBSDKShareLinkContent.init()
        linkShareContent.contentURL = URL.init(string: "https://www.facebook.com/english4ucoffeeclub/")
        btnShare.shareContent = linkShareContent
        let user = obj as! UserModel
        lblCode.text = user.userCode
        lblCheckin.text = "visit".localize() + " \(user.checkIntime.description) " + "times".localize()
    }
    
}
