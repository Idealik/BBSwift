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
    private let authorizationView:AuthorizationView

    init(authorizationInteractor:AuthorizationInteractor, authorizationView:AuthorizationView) {
        self.authorizationInteractor = authorizationInteractor
        self.authorizationView = authorizationView
        return
    }
    
    func defaultAuthorize() {
        authorizationView.hideViewsOnScreen()
        //authorizationInteractor.defaultAuthorize(this)
    }
    
    func authorize(phone: String) {
        //authorizationInteractor.authorize(phone, this)
    }
    
    func showViewOnScreen() {
        
    }
    
    func setPhoneError() {
        
    }
    
    func goToRegistration(phone: String) {
        
    }
    
    func goToProfile(user: User) {
        
    }
    
    func goToVerifyPhone(phone: String) {
        
    }

}
