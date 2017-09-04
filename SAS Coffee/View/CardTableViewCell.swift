//
//  CardTableViewCell.swift
//  Education Platform
//
//  Created by Duy Cao on 12/9/16.
//  Copyright © 2016 Duy Cao. All rights reserved.
//

import UIKit

class CardTableViewCell: SuperTableViewCell {
    @IBOutlet weak var backgroundCardView : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()

        if backgroundCardView == nil {
            self.backgroundCardView = UIView()
            self.contentView.addSubview(self.backgroundCardView)
            self.contentView.sendSubview(toBack: self.backgroundCardView)
            self.backgroundCardView.autoPinEdgesToSuperviewEdges(with: .init(top: 16, left: 16, bottom: 16, right: 16))
        }
        

        self.backgroundCardView.backgroundColor = UIColor.white
        self.backgroundCardView.layer.cornerRadius = 3.0
        self.backgroundCardView.layer.masksToBounds = false
        self.backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.backgroundCardView.layer.shadowOpacity = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}
