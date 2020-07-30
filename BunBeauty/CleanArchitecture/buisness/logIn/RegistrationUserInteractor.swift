//
//  RegistrationUserInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class RegistrationUserInteractor: IRegistrationUserInteractor, InsertUserCallback {
    
    private var registrationPresenterCallback: RegistrationPresenterCallback?
    var userRepository:UserRepository
    
    init(userRepository:UserRepository) {
        self.userRepository = userRepository
    }
    
    func registerUser(user: User,
                      registrationPresenterCallback: RegistrationPresenterCallback) {
        self.registrationPresenterCallback = registrationPresenterCallback
        userRepository.insert(_user: user, insertUserCallback: self)
    }

    func returnCreatedCallback(obj: User) {
        registrationPresenterCallback?.showSuccessfulRegistration(user: obj)
    }
    
    
}
