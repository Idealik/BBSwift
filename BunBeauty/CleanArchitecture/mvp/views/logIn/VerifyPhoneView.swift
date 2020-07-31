//
//  VerifyPhoneView.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 27.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
protocol VerifyPhoneView {
    func hideViewsOnScreen()
    func showViewsOnScreen()
    func showMessage(message: String)
    func goToRegistration(phone: String)
    func goToProfile(user:User)
}
