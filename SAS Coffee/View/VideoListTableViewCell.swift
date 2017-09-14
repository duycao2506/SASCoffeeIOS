//
//  VideoList.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/11/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class VideoListTableViewCell: CardTableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    @IBOutlet weak var ivVideothumbnail: UIImageView!
    @IBOutlet weak var lblVideoDesc: UILabel!
    @IBOutlet weak var lblVideoTitle: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func updateData(anyObj: Any) {
        
    }
    
    override func updateData(number: Int, str: String, obj: SuperModel) {
        
    }

}
