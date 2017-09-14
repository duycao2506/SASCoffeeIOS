//
//  IvLblDesTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/9/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import PureLayout

class IvLblDesTableViewCell: CardTableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbldesc: UILabel!
    
    @IBOutlet weak var ivicon: UIImageView!
    var isCardView : Bool! = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if !isCardView{
            self.backgroundCardView.layer.shadowColor = UIColor.white.cgColor
            self.backgroundCardView.layer.shadowOpacity = 0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
