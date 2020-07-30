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

class AuthorizationController: UIViewController, AuthorizationView {
    
    @IBOutlet weak var enterPhoneText: UITextField!
    @IBOutlet weak var authorizeAuthorizationBtn: UIButton!
    @IBOutlet weak var loadingAuthorizationIndicatorView: UIActivityIndicatorView!
    
    var authorizationInteractor:AuthorizationInteractor  = AuthorizationInteractor(userRepository: UserRepository.getInstance())
    var authorizationPresenter:AuthorizationPresenter?
    
    //    init?(coder:NSCoder, authorizationPresenter:AuthorizationPresenter){
//        self.authorizationPresenter = authorizationPresenter
//        super.init(coder: coder)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authorizationPresenter = AuthorizationPresenter(authorizationInteractor: authorizationInteractor, authorizationView: self)
        
        //check status in FB
        FirebaseApp.configure()
        
        authorizationPresenter?.defaultAuthorize()
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
