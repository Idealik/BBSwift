//
//  VerifyPhone.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class VerifyPhone: UIViewController {
    
    var myPhoneNumber:String!
    var myVerificationID:String?
    
    @IBOutlet weak var codeInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func myVerifyBtn(_ sender: Any) {
        let verificationCode = codeInput.text
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: myVerificationID!,
            verificationCode: verificationCode!)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error == nil {
                // do

            }
            else{
                print("Error ")
            }
        }
    }
    
    
    
}
