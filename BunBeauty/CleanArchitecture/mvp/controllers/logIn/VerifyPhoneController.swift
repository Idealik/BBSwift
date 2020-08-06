//
//  VerifyPhone.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import Firebase
import MaterialComponents
class VerifyPhoneController: UIViewController, VerifyPhoneView {
    
    var myPhoneNumber:String!
    var myVerificationID:String?
    var verifyPhonePresenter: VerifyPhonePresenter?
    
    var verifyPhoneInteractor:VerifyPhoneInteractor  = VerifyPhoneInteractor(userRepository: UserRepository.getInstance())
    
    @IBOutlet weak var phoneVeifyPhoneInput: MDCTextField!
    @IBOutlet weak var verifyPhoneNumberInput: MDCFilledTextField!
    
    @IBOutlet weak var verifyPhoneBtn: MDCButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneVeifyPhoneInput.text = myPhoneNumber
        verifyPhonePresenter = VerifyPhonePresenter(verifyPhoneInteractor: verifyPhoneInteractor, verifyPhoneView: self)
        sendVerificationCode(_myPhoneNumber: myPhoneNumber)
    }
    
    private func sendVerificationCode(_myPhoneNumber:String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(myPhoneNumber, uiDelegate: nil) { (verificationId, error) in
            if error == nil{
                self.myVerificationID = verificationId
            }
            else{
                print("Unable to get SVC from firebase ")
            }
        }
    }
    
    func initView(){
        verifyPhoneBtn.layer.cornerRadius = CGFloat(Style.buttunCornerRadius)
        verifyPhoneBtn.clipsToBounds = true
    }
    
    @IBAction func myVerifyBtn(_ sender: Any) {
        let verificationCode = verifyPhoneNumberInput.text
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: myVerificationID!,
            verificationCode: verificationCode!)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error == nil {
                self.verifyPhonePresenter?.checkUser(phoneNumber: self.myPhoneNumber)
            }
            else{
                print("Error ")
            }
        }
    }
    
    func hideViewsOnScreen() {
        
    }
    
    func showViewsOnScreen() {
        
    }
    
    func showMessage(message: String) {
        
    }
    
    func goToRegistration(phone: String) {
        let  registrtationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationController") as! RegistrationController
        registrtationVC.myPhoneNumber = phone
        self.dismiss(animated: true)
        navigationController?.pushViewController(registrtationVC, animated: true)
    }
    
    func goToProfile(user:User) {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        profileVC.user = user
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}
