//
//  AudioListViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import FontAwesomeKit
import AVFoundation

class AudioListViewController: KasperViewController, UITableViewDelegate, UITableViewDataSource, AVSpeechSynthesizerDelegate {

    var sentences : List<SentenceModel>!
    
    var audioutter : AVSpeechUtterance? = AVSpeechUtterance.init(string: "Hello")
    let audiosynthesizer : AVSpeechSynthesizer = AVSpeechSynthesizer.init()
    let voice = AVSpeechSynthesisVoice.init(language: "en-US")
    var isPlayingIndex : Int = -1
    var isForceStop : Bool = false
    
    
    @IBOutlet var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        audiosynthesizer.delegate = self
        tbView.register(UINib.init(nibName: ViewNibNames.ivtitledescell, bundle: Bundle.main), forCellReuseIdentifier: TableViewCellIdetifier.icontitledesccell)
        self.tbView.estimatedRowHeight = 100
        self.tbView.rowHeight = UITableViewAutomaticDimension
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.icontitledesccell) as! IvLblDesTableViewCell
        
        
        if indexPath.row == isPlayingIndex {
            cell.ivicon.image = GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.pauseCircleIcon(withSize: 48.0)).changeTint(color: Style.colorPrimary)
        }else {
            cell.ivicon.image = GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.playCircleIcon(withSize: 48.0)).changeTint(color: Style.colorPrimary)
        }
        
        cell.lblTitle.text = sentences[indexPath.row].sentenceEn
        cell.lbldesc.text = sentences[indexPath.row].sentenceVi
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.audiosynthesizer.isSpeaking {
            isForceStop = true
            self.audiosynthesizer.stopSpeaking(at: .immediate)
        }
        
        self.isPlayingIndex = indexPath.row
        self.audioutter? = AVSpeechUtterance.init(string: sentences[indexPath.row].sentenceEn)
        self.audioutter?.voice = voice
        self.audioutter?.rate = 0.5
        self.audiosynthesizer.speak(self.audioutter!)
        self.tbView.reloadData()
    }
    
    
    /// Synthernizer AV Speech
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        
        if isForceStop {
            isForceStop = false
            return
        }
        let row = self.isPlayingIndex
        self.isPlayingIndex = -1
        self.tbView.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: .fade)
        
    }
    


}
