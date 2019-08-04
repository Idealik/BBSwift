//
//  ViewController.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 06/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var enterPhoneText: UITextField!
    @IBOutlet weak var codeInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*FirebaseApp.configure()
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (usersSnapshot) in
            for userSnapshot in usersSnapshot.children{
            
        }
        })*/
        //check status in FB
        FirebaseApp.configure()
        
        let fbUser = Auth.auth().currentUser
        
        if(fbUser != nil){
            //hideViewsOfScreen
            let myPhoneNumber = (fbUser?.phoneNumber)!
            
            let myAuth = MyAuthorization()
            myAuth.authorizeUser(_myPhoneNumber: myPhoneNumber, _context: storyboard!, _controller: self)
            
        }
        else{
            //showViewOnScreen()
            print("HOHOOOOOOOOO")
        }
    }
    
    @IBAction func enterBtn(_ sender: Any) {
        let myPhone = enterPhoneText.text
        if(isPhoneCorrect(_myPhone: myPhone!)){
            goToVerifyPhone(_myPhone: myPhone!)
        }
        
    }
    func isPhoneCorrect(_myPhone:String) -> Bool {
        if _myPhone.isEmpty{
            return false
        }
        return true
    }
    
    func goToVerifyPhone(_myPhone:String){
        let  verifyPhoneVC = storyboard?.instantiateViewController(withIdentifier: "VerifyPhone") as! VerifyPhone
        verifyPhoneVC.myPhoneNumber = _myPhone
        navigationController?.pushViewController(verifyPhoneVC, animated: true)
    }
}

