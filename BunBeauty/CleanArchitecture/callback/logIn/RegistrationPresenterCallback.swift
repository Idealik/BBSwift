//
//  RegistrationPresenterCallback.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
protocol RegistrationPresenterCallback {
    func showSuccessfulRegistration(user: User)
    func registrationNameInputError()
    func registrationNameInputErrorEmpty()
    func registrationNameInputErrorLong()
    func registrationSurnameInputError()
    func registrationSurnameInputErrorEmpty()
    func registrationSurnameInputErrorLong()
    func registrationCityInputError()
}
