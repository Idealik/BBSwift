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
class RegistrationController: UIViewController, RegistrationView {
  
    var registrationUserInteractor:RegistrationUserInteractor  = RegistrationUserInteractor(userRepository: UserRepository.getInstance())
    var registrationPresenter:RegisrationPresenter?
    
    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var surnameInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    
    var myPhoneNumber:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillPhoneInput(phone: myPhoneNumber)
        //FirebaseApp.configure()
        registrationPresenter = RegisrationPresenter(registrationUserInteractor: registrationUserInteractor, registrationView: self)
        
    }
    
    @IBAction func registrateBtn(_ sender: Any) {
       registrationPresenter?.registerUser(name: nameInput.text ?? "",
                                           surname: surnameInput.text ?? "",
                                           city: cityInput.text ?? "",
                                           phone: phoneInput.text ??   "")
    }
    
    func setNameInputError(error: String) {
        
    }
    
    func setSurnameInputError(error: String) {
        
    }
    
    func showNoSelectedCity() {
        
    }
    
    func fillPhoneInput(phone: String) {
        phoneInput.text = phone
    }
    
    func showSuccessfulRegistration() {
        
    }
    
    func goToProfile(user: User) {
        let  profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        profileVC.user = user
        self.dismiss(animated: true)
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
