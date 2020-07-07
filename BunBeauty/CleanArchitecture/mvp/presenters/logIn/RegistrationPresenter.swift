//
//  RegistrationPresenter.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class RegisrationPresenter : RegistrationPresenterCallback{
    
    
    func registerUser(name: String, surname: String, city: String, phone: String) {
        var user = User()
        user.name = name
        user.surname = surname
        user.city = city
        user.phone = phone
        //registrationUserInteractor.registerUser(user, this)
    }
    
    func getMyPhoneNumber() {
        //registrationUserInteractor.getMyPhoneNumber()
    }
    
    
    func showSuccessfulRegistration(user: User) {
        
    }
    
    func registrationNameInputError() {
        
    }
    
    func registrationNameInputErrorEmpty() {
        
    }
    
    func registrationNameInputErrorLong() {
        
    }
    
    func registrationSurnameInputError() {
        
    }
    
    func registrationSurnameInputErrorEmpty() {
        
    }
    
    func registrationSurnameInputErrorLong() {
        
    }
    
    func registrationCityInputError() {
        
    }
    
    
}
