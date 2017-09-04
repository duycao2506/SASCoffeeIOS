//
//  KasperButton.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/3/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

@IBDesignable
class KasperButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var normalBackground: UIColor = UIColor.white {
        didSet {
            self.layer.backgroundColor = normalBackground.cgColor
        }
        
    }
    
    @IBInspectable var pressedBackground: UIColor = UIColor.white
    
    @IBInspectable var cornerRadiusLevel : CGFloat = 0 {
        didSet{
            if self.cornerRadiusLevel > 50 {
                self.cornerRadiusLevel = 50
            }
            self.layer.cornerRadius = (self.cornerRadiusLevel * 0.01) * self.layer.frame.width
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.4, animations: {
            self.layer.backgroundColor = self.pressedBackground.cgColor
        })
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.4, animations: {
            self.layer.backgroundColor = self.normalBackground.cgColor
        })
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.4, animations: {
            self.layer.backgroundColor = self.normalBackground.cgColor
        })
    }
    


}
