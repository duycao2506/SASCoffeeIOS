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
    
    var observer : KasperObserverDelegate!
    
    
    
    @IBOutlet weak var ivVideothumbnail: UIImageView!
    @IBOutlet weak var lblVideoDesc: UILabel!
    @IBOutlet weak var lblVideoTitle: UILabel!
    
    var vidid : String! = ""
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func press_btnPlay(_ sender: Any) {
        observer.callback(EventConst.PLAY_VIDEO, true, vidid)
    }
    override func updateData(anyObj: Any) {
        let video = anyObj as! VideoModel
        self.lblVideoTitle.text = video.name
        self.lblVideoDesc.text = video.length
        self.ivVideothumbnail.sd_setImage(with: URL.init(string: "https://img.youtube.com/vi/\(video.videoId)/0.jpg"), completed: nil)
        self.vidid = video.videoId
    }
    
    override func updateData(number: Int, str: String, obj: SuperModel) {
        
    }

}
