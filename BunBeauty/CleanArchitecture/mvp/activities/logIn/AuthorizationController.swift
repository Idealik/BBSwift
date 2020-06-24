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
    @IBOutlet weak var codeInput: UITextField!
    
    var authorizationInteractor:AuthorizationInteractor  = AuthorizationInteractor()
    
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

        let authorizationPresenter:AuthorizationPresenter = AuthorizationPresenter(authorizationInteractor: authorizationInteractor, authorizationView: self)
        
        //check status in FB
        FirebaseApp.configure()
        
        authorizationPresenter.defaultAuthorize()
    }
    
    @IBAction func enterBtn(_ sender: Any) {
        
    }
    
    func hideViewsOnScreen() {
        
    }
    
    func showViewsOnScreen() {
        
    }
    
    func showPhoneError(error: String) {
        
    }
    
    func enableVerifyBtn(status: Bool) {
        
    }
    
    func goToVerifyPhone(phone: String) {
        let  verifyPhoneVC = storyboard?.instantiateViewController(withIdentifier: "VerifyPhone") as! VerifyPhone
        verifyPhoneVC.myPhoneNumber = phone
        navigationController?.pushViewController(verifyPhoneVC, animated: true)
    }
    
    func goToRegistration(phone: String) {
        let  registrtationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationController") as! RegistrationController
        registrtationVC.myPhoneNumber = phone
        navigationController?.pushViewController(registrtationVC, animated: true)
    }
    
    func goToProfile(user: User) {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        //set user
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}
