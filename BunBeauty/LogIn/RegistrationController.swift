//
//  Registration.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 08/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class RegistrationController: UIViewController {
    
    private let PHONE:String = "phone"
    private let USERS:String = "users"
    private let NAME:String = "name"
    private let CITY:String = "city"
    private let AVG_RATING:String = "avg rating"
    private let COUNT_OF_RATES:String = "count of rates"
    private let PHOTO_LINK:String = "photo link"

    private let defaultPhotoLink:String = "https://firebasestorage." +
        "googleapis.com/v0/b/bun-beauty.appspot.com/o/avatar/defaultAva." +
    "jpg?alt=media&token=f15dbe15-0541-46cc-8272-2578627ed311"
    
    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var surnameInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    
    var myPhoneNumber:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneInput.text = myPhoneNumber!
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrateBtn(_ sender: Any) {
        if areInputCorrect(){
            let name:String = nameInput.text!
            let surname:String = surnameInput.text!
            if name.count > 20{
                print("too much name lenght")
                return
            }else{
                if surname.count > 20 {
                    print("too much surname lenght")
                    return
                }else{
                    let user = UserEntity()
                    let fullName = name + " " + surname
                    user.setName(_name: fullName.lowercased())
                    user.setCity(_city: cityInput.text!.lowercased())
                    user.setPhone(_phone: myPhoneNumber)
                    
                    registration(_user: user)
                    goToProfile(_myPhoneNumber: myPhoneNumber)
                }
            }
        }
    }
    
    func registration(_user:UserEntity) {
        var userRef = Database.database().reference().child(USERS)
        
        var items :Dictionary <String,Any> = [:]
        items.updateValue(_user.getName(), forKey: NAME)
        items.updateValue(_user.getCity(), forKey: CITY)
        items.updateValue(_user.getPhone(), forKey: PHONE)
        items.updateValue(0, forKey: AVG_RATING)
        items.updateValue(0, forKey: COUNT_OF_RATES)
        items.updateValue(defaultPhotoLink, forKey: PHOTO_LINK)
        
        let userId = Auth.auth().currentUser?.uid
        _user.setId(data: userId!)
        userRef = userRef.child(userId!)
        userRef.updateChildValues(items)
        addUserInLocalSrorage(_user: _user)
    }
    
    private func addUserInLocalSrorage(_user:UserEntity){
        
        addPhotoInLocalStorage(_user:_user)
    }
    
    func addPhotoInLocalStorage(_user:UserEntity) {
    
    }
    
    func areInputCorrect() -> Bool {
        if nameInput.text!.isEmpty {
            return false
        }
        if surnameInput.text!.isEmpty {
            return false
        }
        if cityInput.text!.isEmpty{
            return false
        }
        
        return true
    }
    
    private func goToProfile(_myPhoneNumber:String) {
        let  registrationVC = storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileController
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
}
