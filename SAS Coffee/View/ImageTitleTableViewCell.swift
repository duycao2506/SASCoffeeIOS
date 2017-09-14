//
//  ImageTitleTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/2/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class ImageTitleTableViewCell: SuperTableViewCell {

    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var ivtTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        ivIcon.image = ivIcon.image?.changeTint(color: Style.colorPrimary)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected)
        {
            self.ivIcon.image = self.ivIcon.image?.changeTint(color: Style.colorSecondary)
            self.ivtTitle.textColor = Style.colorSecondary
            self.accessoryView?.tintColor = Style.colorSecondary
        }else{
            self.ivIcon.image = self.ivIcon.image?.changeTint(color: Style.colorPrimary)
            self.ivtTitle.textColor = UIColor.darkGray
            self.accessoryView?.tintColor = UIColor.darkGray
        }

        // Configure the view for the selected state
    }
    
    override func updateData(anyObj: Any) {
        var data = anyObj as! [Any]
        ivIcon.image = (data[0] as! UIImage).changeTint(color: Style.colorPrimary)
        ivtTitle.text = data[1] as! String
        
    }
}
