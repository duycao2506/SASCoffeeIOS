//
//  NewsListViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 10/27/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import FontAwesomeKit

class NewsListViewController: KasperTableViewController{
   
    
    var news : [NewsModel] = [NewsModel].init()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    var fakeTitle : [String] = [
        "Hell world, this is the news from SAS Coffee, yeah, cannot miss it",
        "Tao hỏi thật nhé, có thằng loz nào thừa thời gian đi chơi riêng với một đứa con gái"
    ]
    
    var fakeDesc : [String] = [
        "Phần 1, Thor là một kẻ hiếu chiến, ngông cuồng. Anh đã được cha Odin dạy cho một bài học và tìm ra được \"đạo\" dành cho mình.",
        "Phần 2, Thor tuy đã có định hướng cho cuộc đời mình. Nhưng quyết tâm ấy còn chưa đủ mạnh mẽ, chỉ sau khi anh chứng kiến cái chết của thân mẫu và Loki, cảm xúc ẩn tàng bên trong anh mới ngày càng được thôi thúc. Một đế vương cần phải có được tình yêu thương."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbView.rowHeight = UITableViewAutomaticDimension
        self.tbView.estimatedRowHeight = 313
        self.tbView.spr_beginRefreshing()
        // Do any additional setup after loading the view.
    }
    
    override func refreshData(){
        self.page = 0
        self.pureData()
    }
    
    
    
    func pureData(){
        self.tbView.unnotice()
        RequestService.GET_news_list(page: page, user: AppSetting.sharedInstance().mainUser, complete: { data in
            if let response = data as? [String : Any],
                let newsList = response ["newsList"] as? [[String : Any]],
                response["statuskey"] as! Bool
                {
                    let arr = DataService.parseNews(resp: newsList)
                    if self.page == 0 {
                        if newsList.count <= 0 {
                            self.tbView.notice(icon: GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.moodBadIcon(withSize: 48.0)), message: "Sorry, We don't find any news for you".localize())
                        }
                        self.news = arr
                    }else{
                        self.news += arr
                        if newsList.count <= 0 {
                            self.page -= 1
                        }
                    }
                    self.tbView.reloadData()
                    
                    
            }else{
                self.tbView.notice(icon: GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.moodBadIcon(withSize: 48.0)), message: "Sorry, Cannot fetch the data, you may want to check the internet connection".localize())
            }
            self.tbView.spr_endRefreshing()
        })
    }
    
    override func loadMore(){
        self.page += 1
        self.pureData()
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
    
    /*
         TableView Functions
     */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbView.dequeueReusableCell(withIdentifier: TableViewCellIdetifier.newslistcell) as! NewsTableViewCell
        cell.updateData(anyObj: self.news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppStoryBoard.News.instance.instantiateViewController(withIdentifier: VCIdentifiers.NewsDetailsVC.rawValue) as! NewsDetailsViewController
        vc.newsEntity = self.news[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
    
    
}
