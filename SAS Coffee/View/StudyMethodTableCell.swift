//
//  StudyMethodTableCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/10/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class StudyMethodTableCell: CardTableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundCardView.layer.shadowOpacity = 0
        self.selectionStyle = .none
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
