//
//  IRegistrationInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
protocol IRegistrationUserInteractor {
    func registerUser(user: User, registrationPresenterCallback: RegistrationPresenterCallback)
}
