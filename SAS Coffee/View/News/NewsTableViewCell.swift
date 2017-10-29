//
//  NewsTableViewCell.swift
//  SAS Coffee
//
//  Created by Duy Cao on 10/27/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class NewsTableViewCell: CardTableViewCell {

    @IBOutlet weak var lblNewsDesc: UILabel!
    @IBOutlet weak var lblNewsDate: UILabel!
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var imvRepresentative : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateData(anyObj: Any) {
        let object = anyObj as! NewsModel
        self.lblNewsDesc.text = object.descript
        self.lblNewsDate.text = "Posted on ".localize() + (object.expireDate?.string(format: .strict("dd/MM/yyyy")))!
        self.lblNewsTitle.text = object.name
        let str = object.img.split(",")
        
        
        var tempImg = UIImage.init(data: Data.init(base64Encoded: str[1])!)
        
        let differenceRatio = self.imvRepresentative.frame.size.width
                                / (tempImg?.size.width)!
        
        tempImg = tempImg?.resizeImage(scale: differenceRatio)
        
        self.imvRepresentative.image = tempImg
        
        
        
        
    }

    
}
