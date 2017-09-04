//
//  ViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 8/30/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import PureLayout
import Alamofire
import NVActivityIndicatorView
import pop

class EntranceViewController: UIViewController {


    @IBOutlet weak var ivLogo: UIImageView!
    
    var indicator : NVActivityIndicatorView!
    var loginView : LoginUIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        AppSetting.sharedInstance().mainUser = UserModel(id: "21412", name: "CKLD", email: "duydaodac@gmail.com", phone: "214214421", password: "21421412", userCode: "G00124", avatar: "https://scontent.fsgn4-1.fna.fbcdn.net/v/t1.0-9/16681779_1559943140686685_3567998450761641344_n.jpg?oh=2e1ee6755521c1a63592552750f67765&oe=5A1F65A9", birthday: "25/06/1995",  address: "128 Ho van hue", checkTime: 10, fbId: "4214144")
        
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
        
        initIndicator()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(4)
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.moveLogo()
                self.showLoginView()
            }
        }
        indicator.startAnimating()
    }
    
    
    func moveLogo(){
        let endpoint = CGPoint(x: ivLogo.center.x, y: ivLogo.center.y/2.0)
        
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim?.velocity = CGPoint(x: 0, y: -1.0)
        anim?.springBounciness = 10
        anim?.springSpeed = 4
        anim?.toValue = endpoint
        
    
        ivLogo.pop_add(anim, forKey: "up_logo")
    
    }
    
    
    func showLoginView(){
        loginView  = LoginUIView()
        loginView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height/2.0)
        loginView.heightAnchor.constraint(equalToConstant: loginView.frame.height)
        loginView.widthAnchor.constraint(equalToConstant: loginView.frame.width)
        view.addSubview(loginView)
//        print(self.view)
//        

        loginView.btnfb.addTarget(self, action: #selector(EntranceViewController.pressBtnFb), for: .touchUpInside)
        loginView.btngg.addTarget(self, action: #selector(EntranceViewController.pressBtnGg), for: .touchUpInside)
        
        let endPoint : CGPoint = CGPoint(x: self.view.center.x, y: 3*loginView.frame.height/2 )
        print(loginView.constraints)
        print(loginView.frame)
        print(loginView.bounds)
        print(loginView.layer.bounds)
        print(loginView.center)
        
        
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim?.velocity = CGPoint(x: 0, y: -2.0)
        anim?.springBounciness = 2
        anim?.springSpeed = 4
        anim?.toValue = endPoint
        loginView.pop_add(anim, forKey: "up_login")
    }
    
    func pressBtnGg(){
        print("GG")
    }
    
    
    func pressBtnFb(){
        print("FB")
    }
    
    func initIndicator(){
        
        indicator = NVActivityIndicatorView(frame: CGRect.zero )
        indicator.frame.size.height = 50
        indicator.padding = 10
        indicator.color = Style.colorWhite
        
        indicator.type = .ballPulse
        self.view.addSubview(indicator)
        self.indicator.autoPinEdge(.top, to: .bottom, of: self.ivLogo)
        self.indicator.autoPinEdge(.left, to: .left, of: self.ivLogo)
        self.indicator.autoPinEdge(.right, to: .right, of: self.ivLogo)
    }

    
    func initUserFromJson(){
       
    }
    
    func toHomeVC(){
        let hvc = AppStoryBoard.Home.instance.instantiateViewController(withIdentifier: VCIdentifiers.HomeNavViewController.rawValue)
        dismiss(animated: false, completion: nil)
        sleep(3)
        present(hvc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape.intersection(.portrait).intersection(.allButUpsideDown)
    }


}

