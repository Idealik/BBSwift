//
//  RegisrationView.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
protocol RegistrationView {
    func setNameInputError(error: String)
    func setSurnameInputError(error: String)
    func showNoSelectedCity()
    func goToProfile(user: User)
    func fillPhoneInput(phone: String)
    func showSuccessfulRegistration()
}
