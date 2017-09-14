//
//  MeaningTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/10/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class MeaningTableViewCell: SuperTableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var meaningtitle: UIView!
    @IBOutlet weak var wordType: UILabel!
    @IBOutlet weak var phienam: UILabel!
    @IBOutlet weak var definition: UILabel!
    @IBOutlet weak var example: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateData(number : Int, str : String, obj : SuperModel){
        
    }
    
    override func updateData(anyObj : Any){
        
    }

}
