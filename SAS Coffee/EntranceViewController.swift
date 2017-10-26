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
import ObjectMapper
import FacebookLogin
import Firebase
import GoogleSignIn
import FontAwesomeKit

class EntranceViewController: KasperViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    
    
    @IBOutlet weak var ivLogo: UIImageView!
    
    var indicator : NVActivityIndicatorView!
    var loginView : LoginUIView!
    var isLoaded : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       // AppSetting.sharedInstance().mainUser = UserModel(id: "21412", name: "CKLD", email: "duydaodac@gmail.com", phone: "214214421", password: "21421412", userCode: "G00124", avatar: "https://scontent.fsgn4-1.fna.fbcdn.net/v/t1.0-9/16681779_1559943140686685_3567998450761641344_n.jpg?oh=2e1ee6755521c1a63592552750f67765&oe=5A1F65A9", birthday: "25/06/1995",  address: "128 Ho van hue", checkTime: 10, fbId: "4214144")
        
        
        // Do any additional setup after loading the view, typically from a nib.
        ivLogo.center.x = self.view.frame.width/2
        ivLogo.center.y = self.view.frame.height/2
        self.maxheightnoti  = 56
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate =  self
        initIndicator()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        if !isLoaded {
            isLoaded = true
            indicator.startAnimating()
            var result = RealmWrapper.realm.objects(UserModel.self)
            if let user = result.first{
                RequestService.GET_login(endpoint: RequestService.GET_LOGIN_AUTO, token: user.token.toBase64(), complete: {
                    data -> Void in
                    let response = data as! [String : Any]
                    
                    if (response["statuskey"] as! Bool) && DataService.assignUser(response: response, vc: self){
                        RealmWrapper.save(obj: AppSetting.sharedInstance().mainUser)
                        result = RealmWrapper.realm.objects(UserModel.self)
                        AppSetting.sharedInstance().mainUser = result.first
                        self.toHomeVC()
                    }else{
                        self.indicator.stopAnimating()
                        self.moveLogoUp()
                        self.showLoginView()
                    }
                })
            }else{
                self.indicator.stopAnimating()
                self.moveLogoUp()
                self.showLoginView()
            }
            
        }
    }
    
    
    func moveLogoUp(){
        let endpoint = CGPoint(x: ivLogo.center.x, y: self.view.frame.height / 4)
        
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
    
    func moveLogoDown(){
        let endpoint = CGPoint(x: ivLogo.center.x, y: self.view.frame.height / 2)
        
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim?.velocity = CGPoint(x: 0, y: 2.0)
        anim?.springBounciness = 10
        anim?.springSpeed = 4
        anim?.toValue = endpoint
        anim?.removedOnCompletion = false
        anim?.completionBlock = {
            (anim, succ) -> Void in
            self.ivLogo.center = endpoint
        }
        ivLogo.pop_add(anim, forKey: "down_logo")
    }
    
    
    func showLoginView(){
        if loginView == nil {
            loginView  = LoginUIView()
            loginView.btnfb.setImage(GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.facebookIcon(withSize: 24.0)).changeTint(color: UIColor.white), for: .normal)
            loginView.btngg.setImage(GlobalUtils.getDefaultSizeImage(fakmat: FAKMaterialIcons.googleIcon(withSize: 24.0)).changeTint(color: UIColor.white), for: .normal)
            loginView.btnfb.addTarget(self, action: #selector(EntranceViewController.pressBtnFb), for: .touchUpInside)
            loginView.btngg.addTarget(self, action: #selector(EntranceViewController.pressBtnGg), for: .touchUpInside)
            loginView.btnEmail.addTarget(self, action: #selector(EntranceViewController.pressBtnEmail), for: .touchUpInside)
            view.addSubview(loginView)
            loginView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height/2.0)
            loginView.heightAnchor.constraint(equalToConstant: loginView.frame.height)
            loginView.widthAnchor.constraint(equalToConstant: loginView.frame.width)
        }
        
        
//        print(self.view)
//
        let endPoint : CGPoint = CGPoint(x: self.view.center.x, y: 3*loginView.frame.height/2 )
        
        
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim?.velocity = CGPoint(x: 0, y: -2.0)
        anim?.springBounciness = 2
        anim?.springSpeed = 4
        anim?.toValue = endPoint
        loginView.pop_add(anim, forKey: "up_login")
    }
    
    func hideLoginView(){
        let endPoint : CGPoint = CGPoint.init(x: self.view.center.x, y: 5*loginView.frame.height/2)
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim?.velocity = CGPoint(x:0, y: 2.0)
        anim?.springBounciness = 2
        anim?.springSpeed = 4
        anim?.toValue = endPoint
        loginView.pop_add(anim, forKey: "down_login")
        
    }
    
    
    func pressBtnGg(){
        GIDSignIn.sharedInstance().signIn()
    }
    
    func toHomeVC(){
        let homevc = AppStoryBoard.Home.instance.instantiateViewController(withIdentifier: VCIdentifiers.HomeNavViewController.rawValue) as! HomeNavViewController
        let menuvc = AppStoryBoard.Menu.instance.instantiateViewController(withIdentifier: VCIdentifiers.MenuViewController.rawValue) as! MenuViewController
        menuvc.vcArray = homevc.viewControllers as! [KasperViewController]
        let drawercontroller = DrawerController.init(centerViewController: homevc, leftDrawerViewController: menuvc)
        drawercontroller.openDrawerGestureModeMask = .all
        drawercontroller.closeDrawerGestureModeMask = .all
        drawercontroller.shadowRadius = 2.0
        drawercontroller.shouldStretchDrawer = true
        drawercontroller.shadowOpacity = 0.5
        

        self.present(drawercontroller, animated: true, completion: {
            self.indicator.stopAnimating()
            self.moveLogoUp()
            self.showLoginView()
        })

        
      
        
    }
    
    func pressBtnFb(){
        print("FB")
        
        let loginManager = LoginManager.init()
        loginManager.logIn( [.publicProfile, .custom("user_birthday"), .custom("email")], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let _, let _, let accessToken):
                print("Logged in! \(accessToken)")
                self.indicator.startAnimating()
                self.hideLoginView()
                self.moveLogoDown()
                RequestService.GET_login(endpoint: RequestService.GET_LOGIN_FB, token: accessToken.authenticationToken, complete: {
                    data -> Void in
                    let response = data as! [String : Any]
                    if DataService.assignUser(response: response, vc: self){
                        RealmWrapper.save(obj: AppSetting.sharedInstance().mainUser)
                        let result = RealmWrapper.realm.objects(UserModel.self)
                        AppSetting.sharedInstance().mainUser = result.first
                        self.toHomeVC()
                    }
                })
            }
        }
    }
    
    func pressBtnEmail(){
        let loginnavvc  = AppStoryBoard.Login.instance.instantiateViewController(withIdentifier: VCIdentifiers.LoginNavVC.rawValue) as! LoginNavViewController
        loginnavvc.caller = self
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
        
        // Outter VC : Email
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
            
            // Outer VC 1 : Password
            passwordInputVC.continueNextVC = {
                (previousData2, nav2) -> Void in
                
                //Check email to decide next step: EXIST ? LOGIN : Confirmpassword
                nav2.view.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo"), tag: nil)
                RequestService.GET_check_email(email: previousData2["email"] as! String, complete: {
                    data -> Void in
                    let resp = data as! [String:Any]
                    if resp["statuskey"] as! Bool {
                        if resp["exist"] as! Bool {
                            RequestService.POST_loginWithEmail(email: previousData2["email"] as! String, password: previousData2["password"] as! String, complete: {
                                datalogin -> Void in
                                print(datalogin)
                                if DataService.assignUser(response: datalogin as! [String : Any], vc: self){
                                    nav2.view.stopLoading(loadingViewTag: nil)
                                    nav2.dismiss(animated: true, completion: {
                                        RealmWrapper.save(obj: AppSetting.sharedInstance().mainUser)
                                        self.toHomeVC()
                                    })
                                }
                            })
                        }else{
                            
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
                            //Outer VC 2 : Confirm password
                            confirmPasswordVC.continueNextVC = {
                                (previousData3, nav3) -> Void in
                                let basicinfoVC = AppStoryBoard.Login.instance.instantiateViewController(withIdentifier: VCIdentifiers.BasicInfoVc.rawValue) as! BasicInfoViewController
                                basicinfoVC.data = previousData3
                                nav3.pushViewController(basicinfoVC, animated: true)
                            }
                            nav2.view.stopLoading(loadingViewTag: nil)
                            nav2.pushViewController(confirmPasswordVC, animated: true)
                        }
                    }
                })
                
                
                
            }
            nav1.pushViewController(passwordInputVC, animated: true)
        }
        present(loginnavvc, animated: true, completion: nil)
    }
    
    func initIndicator(){
        self.indicator = GlobalUtils.getNVIndicatorView(color: Style.colorWhite, type: .ballPulse)
        self.view.addSubview(self.indicator)
        self.indicator.autoPinEdge(.top, to: .bottom, of: self.ivLogo)
        self.indicator.autoPinEdge(.left, to: .left, of: self.ivLogo)
        self.indicator.autoPinEdge(.right, to: .right, of: self.ivLogo)
    }

    
    func initUserFromJson(){
       
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
    
    /**
    ** Sign in google delegate
    */
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            
            let authCode = user.authentication.idToken
            if authCode == nil {
                notiTextview?.text = "Fail to get serverAuthCode"
                showNotification()
                return
            }
            self.indicator.startAnimating()
            self.hideLoginView()
            self.moveLogoDown()
            RequestService.GET_login(endpoint: RequestService.GET_LOGIN_GMAIL, token: authCode!, complete: {
                data -> Void in
                let response = data as! [String: Any]
                print(response)
                if (response["statuskey"] as! Bool) && DataService.assignUser(response: response, vc: self){
                    RealmWrapper.save(obj: AppSetting.sharedInstance().mainUser)
                    self.toHomeVC()
                }else {
                    self.notiTextview?.text = "Fail to login"
                    self.showNotification()
                    self.indicator.startAnimating()
                    self.hideLoginView()
                    self.moveLogoDown()
                }
            })
            print("auth login google \(String(describing: authCode))")
        }else{
            notiTextview?.text = "Fail"
            showNotification()
        }
    }
    
    private func signInWillDispatch(signIn: GIDSignIn!, error: Error!) {
        
    }
    internal func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    internal func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func callback(_ code: Int?, _ succ: Bool?, _ data: Any) {
        let codesure = code!
        switch codesure {
        case EventConst.REGISTER_SUCCESS:
            print(data)
            RealmWrapper.save(obj: AppSetting.sharedInstance().mainUser)
            self.toHomeVC()
            break
        default:
            break
        }
    }
    
    
    
}

