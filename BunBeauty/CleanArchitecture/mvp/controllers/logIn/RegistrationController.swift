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
import iOSDropDown
import MaterialComponents
class RegistrationController: UIViewController, RegistrationView {
    
    var registrationUserInteractor:RegistrationUserInteractor  = RegistrationUserInteractor(userRepository: UserRepository.getInstance())
    var registrationPresenter:RegisrationPresenter?
    
    @IBOutlet weak var phoneInput: MDCBaseTextField!
    @IBOutlet weak var nameInput: MDCFilledTextField!
    @IBOutlet weak var surnameInput: MDCBaseTextField!
    @IBOutlet weak var citySpinner: DropDown!
    @IBOutlet weak var saveRegistrationBtn: MDCButton!
    var myPhoneNumber:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillPhoneInput(phone: myPhoneNumber)
        citySpinner.optionArray = Strings.cicites
        registrationPresenter = RegisrationPresenter(registrationUserInteractor: registrationUserInteractor, registrationView: self)
    }
    
    func initView(){
        saveRegistrationBtn.layer.cornerRadius = CGFloat(Style.buttunCornerRadius)
        saveRegistrationBtn.clipsToBounds = true
        nameInput.placeholder = Strings.name
    }
    
    @IBAction func registrateBtn(_ sender: Any) {
        registrationPresenter?.registerUser(name: nameInput.text ?? "",
                                            surname: surnameInput.text ?? "",
                                            city: citySpinner.text ?? "",
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
