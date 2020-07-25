//
//  RegistrationPresenter.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class RegisrationPresenter : RegistrationPresenterCallback{
    
    private let registrationUserInteractor:IRegistrationUserInteractor
    private let registrationView:RegistrationView
    
    init(registrationUserInteractor:RegistrationUserInteractor, registrationView:RegistrationView) {
        self.registrationUserInteractor = registrationUserInteractor
        self.registrationView = registrationView
        return
    }
    
    func registerUser(name: String, surname: String, city: String, phone: String) {
        var user = User()
        user.name = name
        user.surname = surname
        user.city = city
        user.phone = phone
        registrationUserInteractor.registerUser(user: user, registrationPresenterCallback: self)
    }
    
    func showSuccessfulRegistration(user: User) {
        registrationView.showSuccessfulRegistration()
        registrationView.goToProfile(user: user)
    }
    
    func registrationNameInputError() {
        registrationView.setNameInputError(error: "Неккоректно введено имя")
    }
    
    func registrationNameInputErrorEmpty() {
        registrationView.setNameInputError(error: "Введите имя")
    }
    
    func registrationNameInputErrorLong() {
        registrationView.setNameInputError(error: "Неккоректно введено имя")
    }
    
    func registrationSurnameInputError() {
        registrationView.setNameInputError(error: "Неккоректно введена фамилия")
    }
    
    func registrationSurnameInputErrorEmpty() {
        registrationView.setNameInputError(error: "Введите фамилию")
    }
    
    func registrationSurnameInputErrorLong() {
        registrationView.setNameInputError(error: "Неккоректно введена фамилия")
    }
    
    func registrationCityInputError() {
        registrationView.setNameInputError(error: "Выберите город")
    }
}
