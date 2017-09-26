//
//  LoginUIView.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/3/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import FontAwesomeKit

@IBDesignable
class LoginUIView: NibView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var btnEmail : KasperButton!
    @IBOutlet weak var btnfb : KasperButton!
    @IBOutlet weak var btngg : KasperButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btngg.setImage(GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.googleIcon(withSize: 48.0)).changeTint(color: UIColor.white), for: .normal)
    }
}
