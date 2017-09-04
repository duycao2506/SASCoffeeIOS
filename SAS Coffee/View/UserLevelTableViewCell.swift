//
//  UserLevelTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/2/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class UserLevelTableViewCell: SuperTableViewCell {

    @IBOutlet weak var ivcup1: UIImageView!
    @IBOutlet weak var ivcup2: UIImageView!
    @IBOutlet weak var ivcup3: UIImageView!
    @IBOutlet weak var ivcup4: UIImageView!
    @IBOutlet weak var pvPoint: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("Hello World")
        ivcup1.image = ivcup1.image?.changeTint(color: Style.colorSupplementary1)
        
        ivcup2.image = ivcup1.image?.changeTint(color: Style.colorWhiteHard)
        
        ivcup3.image = ivcup1.image?.changeTint(color: Style.colorYellow)
        
        ivcup4.image = ivcup1.image?.changeTint(color: Style.colorPrimaryLight)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateData(number: Int, str: String, obj: SuperModel) {
        
    }

}
