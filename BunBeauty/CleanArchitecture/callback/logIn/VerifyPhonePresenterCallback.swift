//
//  VerifyPhonePresenterCallback.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 27.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
protocol VerifyPhonePresenterCallback {
    func goToRegistration(phone: String)
    func goToProfile(user:User)
    func showTooManyRequestsError()
    func showVerificationFailed()
    func showTooShortCodeError()
    func showWrongCodeError()
}
