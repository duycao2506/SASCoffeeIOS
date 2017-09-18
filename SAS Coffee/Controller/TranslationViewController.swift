//
//  TranslationViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import AVFoundation

class TranslationViewController: KasperViewController, UITableViewDelegate, UITableViewDataSource {

    
    var dicts : [DictionaryModel] = [DictionaryModel].init()

    @IBOutlet weak var btnSpeak: UIButton!
    @IBOutlet weak var txtTranslate: UITextField!
    @IBOutlet weak var btnTranslate: KasperButton!
    @IBOutlet weak var topCardView: UIView!
    @IBOutlet weak var tbViewTr: UITableView!
    
    @IBOutlet weak var tvTo: UILabel!
    
    var haveData : Bool! = false
    
    @IBOutlet weak var viewHolderTbView: UIView!
    @IBOutlet weak var tvFrom: UILabel!
    
    @IBOutlet weak var lblTranslateResults: UILabel!
    @IBOutlet weak var lblResultHeightConstraint: NSLayoutConstraint!
    var toEng : Bool = false
    
    @IBAction func press_ChangeLang(_ sender: Any) {
        self.toEng = !self.toEng
        let temp = self.tvTo.text
        self.tvTo.text = self.tvFrom.text
        self.tvFrom.text = temp
    }
    
    @IBAction func press_btnRead(_ sender: Any) {
        let utterance = AVSpeechUtterance.init(string: self.txtTranslate.text!)
        utterance.voice = AVSpeechSynthesisVoice.init(language: "en-US")
        utterance.rate = 0.5
        let synthernizer = AVSpeechSynthesizer.init()
        synthernizer.speak(utterance)
    }
    
    @IBAction func press_Translate(_ sender: Any) {
        print("hello")
        self.btnTranslate.isEnabled = false
        self.btnTranslate.normalBackground = UIColor.gray
        self.viewHolderTbView.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo"), tag: nil)
        self.txtTranslate.resignFirstResponder()
        RequestService.POST_translate(input: txtTranslate.text!, isToEng: self.toEng, complete: {
            data -> Void in
            let resp = data as! [String : Any]
            if let dataGet = resp["data"]{
                let dataGet2 = dataGet as! [String : Any]
                if let trans = dataGet2["translations"]{
                    let transjsons = trans as! [[String:Any]]
                    var translateText = ""
                    for item in transjsons {
                        translateText += "\(item["translatedText"] as! String),"
                    }
                    translateText = translateText.substring(0, length: translateText.length-1)
                    self.lblTranslateResults.text = translateText
                }
            }
            self.lblResultHeightConstraint.constant = 36
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
                self.setupView()
            })
            if self.toEng {
                self.dicts = [DictionaryModel].init()
                self.tbViewTr.reloadData()
                self.btnTranslate.backgroundColor = Style.colorSecondary
                self.viewHolderTbView.stopLoading(loadingViewTag: nil)
                self.btnTranslate.isEnabled = true
                return
            }
            RequestService.GET_word_fam(input: self.txtTranslate.text!, complete: {
                data -> Void in
                let resp = data as! [String : Any]
                if resp["status"] as! Int == 200 {
                    let responseArray = resp["results"]
                    self.dicts = DataService.parseDictionary(resp: responseArray as! [[String : Any]])
                    print(self.dicts)
                    
                    self.tbViewTr.reloadData()
                }
                self.btnTranslate.backgroundColor = Style.colorSecondary
                self.viewHolderTbView.stopLoading(loadingViewTag: nil)
                self.btnTranslate.isEnabled = true
            })
        })
    }
    
    
    func setupView(){
        btnSpeak.setImage(btnSpeak.image(for: .normal)?.changeTint(color: Style.colorPrimary), for: .normal)
        self.topCardView.layer.shadowPath = UIBezierPath.init(rect: self.topCardView.bounds).cgPath
        self.topCardView.layer.masksToBounds = false
        self.topCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.topCardView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.topCardView.layer.shadowOpacity = 0.8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbViewTr.estimatedRowHeight = 250
        self.tbViewTr.rowHeight = UITableViewAutomaticDimension
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tbViewTr.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.meaningCell)! as! MeaningTableViewCell
        cell.updateData(anyObj: self.dicts[indexPath.row])
        return cell
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
