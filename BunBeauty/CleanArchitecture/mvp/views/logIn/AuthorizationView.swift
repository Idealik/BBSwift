//
//  AuthorizationView.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 15.05.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
protocol AuthorizationView {
    func hideViewsOnScreen()
    func showViewsOnScreen()
    func showPhoneError(error:String)
    func enableVerifyBtn(status:Bool)
    func goToVerifyPhone(phone:String)
    func goToRegistration(phone: String)
    func goToProfile(user: User)
}
