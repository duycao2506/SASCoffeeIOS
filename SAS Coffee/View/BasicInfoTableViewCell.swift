//
//  BasicInfoTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/2/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import SDWebImage

class BasicInfoTableViewCell: SuperTableViewCell {

    
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblUserLevel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivAvatar.layer.cornerRadius = ivAvatar.frame.size.width / 2
        ivAvatar.clipsToBounds = true
        ivAvatar.layer.masksToBounds = true
        ivAvatar.layer.shouldRasterize = true
        ivAvatar.layer.rasterizationScale = UIScreen.main.scale
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateData(number: Int, str: String, obj: SuperModel) {
        let user = obj as! UserModel
        ivAvatar.sd_setImage(with: URL.init(string: user.avatar), placeholderImage: #imageLiteral(resourceName: "user"), completed: nil)
        lblName.text = user.name
        lblPoint.text = user.point.description
        lblUserLevel.text = "New member"
    }
    
    
    
}
