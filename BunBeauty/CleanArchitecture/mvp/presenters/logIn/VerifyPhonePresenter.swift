//
//  VerifyPhonePresenter.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 27.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class VerifyPhonePresenter: VerifyPhonePresenterCallback {
    
    
    private let verifyPhoneInteractor:VerifyPhoneInteractor
    private let verifyPhoneView:VerifyPhoneView
    
    init(verifyPhoneInteractor:VerifyPhoneInteractor, verifyPhoneView:VerifyPhoneView) {
        self.verifyPhoneInteractor = verifyPhoneInteractor
        self.verifyPhoneView = verifyPhoneView
        return
    }
    
    func checkUser(phoneNumber:String)  {
        verifyPhoneInteractor.checkUser(phoneNumber: phoneNumber, verifyPresenterCallback: self)
    }
    
    func goToRegistration(phone: String) {
        verifyPhoneView.goToRegistration(phone: phone)
    }
    
    func goToProfile(user:User) {
        verifyPhoneView.goToProfile(user: user)
    }
    
    func showTooManyRequestsError() {
        
    }
    
    func showVerificationFailed() {
        
    }
    
    func showTooShortCodeError() {
        
    }
    
    func showWrongCodeError() {
        
    }
    
}
