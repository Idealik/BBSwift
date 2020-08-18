//
//  AuthorizationPresenter.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 15.05.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation

class AuthorizationPresenter : AuthorizationPresenterCallback {
    
    private let authorizationInteractor:AuthorizationInteractor
    var authorizationView:AuthorizationView?
    
    init(authorizationInteractor:AuthorizationInteractor) {
        self.authorizationInteractor = authorizationInteractor
        return
    }
    
    func defaultAuthorize() {
        authorizationView?.hideViewsOnScreen()
        authorizationInteractor.defaultAuthorize(authorizationPresenterCallback: self)
    }
    
    func authorize(phone: String) {
        authorizationInteractor.authorize(phone:phone, authorizationPresenterCallback: self)
    }
    
    func showViewOnScreen() {
        authorizationView?.showViewsOnScreen()
    }
    
    func setPhoneError() {
        authorizationView?.showPhoneError(error: "Неккоректно введен номер")
    }
    
    func goToRegistration(phone: String) {
        authorizationView?.goToRegistration(phone: phone)
    }
    
    func goToProfile(user: User) {
        authorizationView?.goToProfile(user: user)
    }
    
    func goToVerifyPhone(phone: String) {
        authorizationView?.goToVerifyPhone(phone: phone)
    }
    
}
