//
//  VideoPlayerControllerViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/17/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayerController: KasperViewController, YTPlayerViewDelegate {

    
    @IBOutlet weak var yplayer : YTPlayerView!
    
    var code : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yplayer.delegate = self
        self.yplayer.load(withVideoId: code)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        yplayer.playVideo()
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
