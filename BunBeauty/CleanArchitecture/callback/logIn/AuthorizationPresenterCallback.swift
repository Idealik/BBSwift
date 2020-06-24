//
//  AuthorizationPresenterCallback.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 24.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
protocol AuthorizationPresenterCallback {
    func showViewOnScreen()
    func setPhoneError()
    func goToRegistration(phone: String)
    func goToProfile(user: User)
    func goToVerifyPhone(phone: String)
}
