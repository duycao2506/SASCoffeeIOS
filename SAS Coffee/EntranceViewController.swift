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

import DrawerController

class EntranceViewController: UIViewController {


    @IBOutlet weak var ivLogo: UIImageView!
    
    var indicator : NVActivityIndicatorView!
    var loginView : LoginUIView!
    var isLoaded : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        AppSetting.sharedInstance().mainUser = UserModel(id: "21412", name: "CKLD", email: "duydaodac@gmail.com", phone: "214214421", password: "21421412", userCode: "G00124", avatar: "https://scontent.fsgn4-1.fna.fbcdn.net/v/t1.0-9/16681779_1559943140686685_3567998450761641344_n.jpg?oh=2e1ee6755521c1a63592552750f67765&oe=5A1F65A9", birthday: "25/06/1995",  address: "128 Ho van hue", checkTime: 10, fbId: "4214144")
        
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
        
        initIndicator()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        if !isLoaded {
            isLoaded = true
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
    }
    
    
    func moveLogo(){
        let endpoint = CGPoint(x: ivLogo.center.x, y: ivLogo.center.y/2.0)
        
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim?.velocity = CGPoint(x: 0, y: -2.0)
        anim?.springBounciness = 10
        anim?.springSpeed = 4
        anim?.toValue = endpoint
        anim?.removedOnCompletion = false
        anim?.completionBlock = {
            (anim, succ) -> Void in
            self.ivLogo.center = endpoint
        }
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
        loginView.btnEmail.addTarget(self, action: #selector(EntranceViewController.pressBtnEmail), for: .touchUpInside)
        
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
        let homevc = AppStoryBoard.Home.instance.instantiateViewController(withIdentifier: VCIdentifiers.HomeNavViewController.rawValue) as! HomeNavViewController
        let menuvc = AppStoryBoard.Menu.instance.instantiateViewController(withIdentifier: VCIdentifiers.MenuViewController.rawValue) as! MenuViewController
        menuvc.vcArray = homevc.viewControllers as! [KasperViewController]
        let drawercontroller = DrawerController.init(centerViewController: homevc, leftDrawerViewController: menuvc)
        drawercontroller.openDrawerGestureModeMask = .all
        drawercontroller.closeDrawerGestureModeMask = .all
        drawercontroller.shadowRadius = 2.0
        drawercontroller.shouldStretchDrawer = true
        drawercontroller.shadowOpacity = 0.5
        self.dismiss(animated: true, completion: nil)
        present(drawercontroller, animated: true, completion: nil)
        
    }
    
    
    func pressBtnFb(){
        print("FB")
    }
    
    func pressBtnEmail(){
        let loginnavvc  = AppStoryBoard.Login.instance.instantiateViewController(withIdentifier: VCIdentifiers.LoginNavVC.rawValue) as! LoginNavViewController
        let emailInputVC =  loginnavvc.viewControllers.first as! OneTextFieldViewController
        
        //Define the chain
        emailInputVC.strDesc = "emailDesc".localize()
        emailInputVC.strTitle = "email_screen_title".localize()
        emailInputVC.strPlaceholder = "email".localize()
        emailInputVC.previousData = [String : String] ()
        emailInputVC.dataKey = UserModel.EMAIL
        emailInputVC.continueCondition = {
            (previousData, inputData) -> Bool in
            return GlobalUtils.checkEmail(checkStr: inputData as! String)
        }
        emailInputVC.continueNextVC = {
            (previousData1, nav1) -> Void in
            let passwordInputVC = AppStoryBoard.Login.instance.instantiateViewController(withIdentifier: VCIdentifiers.OneTextInputViewController.rawValue) as! OneTextFieldViewController
            passwordInputVC.previousData = previousData1
            passwordInputVC.strDesc = "passwordDesc".localize()
            passwordInputVC.isSecured = true
            passwordInputVC.dataKey = UserModel.PASSWORD
            passwordInputVC.strTitle = "password".localize()
            passwordInputVC.continueCondition = {
                (previousDataCondition1, inputdata1) -> Bool in
                return (inputdata1 as! String).length > 6
                
            }
            passwordInputVC.strPlaceholder = "password".localize()
            nav1.pushViewController(passwordInputVC, animated: true)
            passwordInputVC.continueNextVC = {
                (previousData2, nav2) -> Void in
                let confirmPasswordVC = AppStoryBoard.Login.instance.instantiateViewController(withIdentifier: VCIdentifiers.OneTextInputViewController.rawValue) as! OneTextFieldViewController
                confirmPasswordVC.previousData = previousData2
                confirmPasswordVC.isSecured = true
                confirmPasswordVC.strDesc = "passwordConfDesc".localize()
                confirmPasswordVC.strTitle = "confirmPass".localize()
                confirmPasswordVC.strPlaceholder = "confirmPass".localize()
                confirmPasswordVC.continueCondition = {
                    (previousDatacond2, inputdata2) -> Bool in
                    return (inputdata2 as! String).compare((previousDatacond2 as! [String: String])[UserModel.PASSWORD]!) == ComparisonResult.orderedSame
                }
                confirmPasswordVC.continueNextVC = {
                    (previousData3, nav3) -> Void in
                    let basicinfoVC = AppStoryBoard.Login.instance.instantiateViewController(withIdentifier: VCIdentifiers.BasicInfoVc.rawValue) as! BasicInfoViewController
                    basicinfoVC.data = previousData3
                    nav3.pushViewController(basicinfoVC, animated: true)
                }
                nav2.pushViewController(confirmPasswordVC, animated: true)
            }
        }
        present(loginnavvc, animated: true, completion: nil)
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

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

