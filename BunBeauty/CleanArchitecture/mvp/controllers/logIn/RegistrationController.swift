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
        phoneInput.text = myPhoneNumber!
        registrationPresenter = RegisrationPresenter(registrationUserInteractor: registrationUserInteractor, registrationView: self)
        
    }
    
    @IBAction func registrateBtn(_ sender: Any) {
       registrationPresenter?.registerUser(name: nameInput.text ?? "", surname: surnameInput.text ?? "", city: cityInput.text ?? "", phone: phoneInput.text ?? "")
    }
    
    func setNameInputError(error: String) {
        
    }
    
    func setSurnameInputError(error: String) {
        
    }
    
    func showNoSelectedCity() {
        
    }
    
    func goToProfile(user: User) {
        let  registrationVC = storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileController
        //перелача юзера
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    func fillPhoneInput(phone: String) {
        
    }
    
    func showSuccessfulRegistration() {
        
    }

    
}
