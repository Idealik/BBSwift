//
//  AuthorizationActivity.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 06/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import MaterialComponents
class AuthorizationController: UIViewController, AuthorizationView {
    
    @IBOutlet weak var enterPhoneText: UITextField!
    @IBOutlet weak var authorizeAuthorizationBtn: MDCButton!
    @IBOutlet weak var loadingAuthorizationIndicatorView: UIActivityIndicatorView!
    
    var authorizationInteractor:AuthorizationInteractor  = AuthorizationInteractor(userRepository: UserRepository.getInstance())
    var authorizationPresenter:AuthorizationPresenter?
    
//    init(authorizationPresenter:AuthorizationPresenter){
//        self.authorizationPresenter = authorizationPresenter
//        super.init(nibName:nil, bundle:nil)
//    }
//
// required init?(coder aDecoder: NSCoder) {
//       super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationPresenter = AuthorizationPresenter(authorizationInteractor: authorizationInteractor, authorizationView: self)
        FirebaseApp.configure()
        initView()
        authorizationPresenter?.defaultAuthorize()
    }
    
    func initView(){
        authorizeAuthorizationBtn.layer.cornerRadius = CGFloat(Style.buttunCornerRadius)
        authorizeAuthorizationBtn.clipsToBounds = true
    }
    
    @IBAction func enterBtn(_ sender: Any) {
        authorizationPresenter?.authorize(phone: enterPhoneText.text ?? "")
    }
    
    func hideViewsOnScreen() {
        loadingAuthorizationIndicatorView.isHidden = false
        
        enterPhoneText.isHidden = true
        authorizeAuthorizationBtn.isHidden = true
    }
    
    func showViewsOnScreen() {
        loadingAuthorizationIndicatorView.isHidden = true
        
        enterPhoneText.isHidden = false
        authorizeAuthorizationBtn.isHidden = false
    }
    
    func showPhoneError(error: String) {
        
    }
    
    func goToVerifyPhone(phone: String) {
        let  verifyPhoneVC = storyboard?.instantiateViewController(withIdentifier: "VerifyPhone") as! VerifyPhoneController
        verifyPhoneVC.myPhoneNumber = phone
        navigationController?.pushViewController(verifyPhoneVC, animated: true)
    }
    
    func goToRegistration(phone: String) {
        let  registrtationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationController") as! RegistrationController
        registrtationVC.myPhoneNumber = phone
        self.dismiss(animated: true)
        navigationController?.pushViewController(registrtationVC, animated: true)
    }
    
    func goToProfile(user: User) {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        profileVC.user = user
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}
