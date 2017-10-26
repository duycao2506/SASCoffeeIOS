//
//  VideoListViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import youtube_ios_player_helper


class VideoListViewController: KasperViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tbView : UITableView!
    
    var videos : [VideoModel] = [VideoModel].init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "via Videos".localize()

        // Do any additional setup after loading the view.
        self.tbView.estimatedRowHeight = 200
        self.tbView.rowHeight = UITableViewAutomaticDimension
        self.tbView.spr_setTextHeader {
            RequestService.GET_all_vid(complete: {
                data -> Void in
                let resp = data as! [String : Any]
                print(resp)
                if resp["statuskey"] as! Bool {
                    self.videos = DataService.parseVideos(resp: resp["data"] as! [[String:Any]])
                }
                print(self.videos)
                self.tbView.reloadData()
                self.tbView.spr_endRefreshing()
            })
        }
        self.tbView.spr_beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.videolistcell)! as! VideoListTableViewCell
        cell.updateData(anyObj: videos[indexPath.row])
        cell.observer = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openVideoController(viid: self.videos[indexPath.row].videoId)
    }
    
    func openVideoController (viid: String){
        let videovc = AppStoryBoard.Study.instance.instantiateViewController(withIdentifier: VCIdentifiers.Videoplayer.rawValue) as! VideoPlayerController
        videovc.modalTransitionStyle = .crossDissolve
        videovc.modalPresentationStyle = .overCurrentContext
        videovc.modalPresentationCapturesStatusBarAppearance = true
        videovc.code = viid
        
        self.present(videovc, animated: true, completion: nil)

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func callback(_ code: Int?, _ succ: Bool?, _ data: Any) {
        let codesure = code!
        switch codesure {
        case EventConst.PLAY_VIDEO:
            self.openVideoController(viid: data as! String)
            break
        default:
            break
        }
    }

}
