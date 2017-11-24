//
//  NewsDetailsViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 10/27/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit

class NewsDetailsViewController: KasperViewController {

    @IBOutlet weak var lblDate: UILabel!
    
    
    @IBOutlet weak var imvRep: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblContent: UITextView!
    
    
    var newsEntity : NewsModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attstring : NSAttributedString =  try! NSAttributedString.init(data: newsEntity.fullDes.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        
        self.lblContent.attributedText = attstring
        self.lblTitle.text = newsEntity.name
        let str = self.newsEntity.img.split(",")
        
        
        var tempImg = UIImage.init(data: Data.init(base64Encoded: str[1])!)
        
        let differenceRatio = self.imvRep.frame.size.width
            / (tempImg?.size.width)!
        
        tempImg = tempImg?.resizeImage(scale: differenceRatio)
        
        self.imvRep.image = tempImg
        
        self.lblDate.text = "Posted on ".localize() + (newsEntity.expireDate?.string(format: .strict("dd/MM/yyyy")))!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
