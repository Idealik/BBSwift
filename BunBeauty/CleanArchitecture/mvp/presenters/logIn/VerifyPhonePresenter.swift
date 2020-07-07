//
//  VerifyPhonePresenter.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 27.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class VerifyPhonePresente: VerifyPhonePresenterCallback {
    
    
    private let verifyPhoneInteractor:VerifyPhoneInteractor
    private let verifyPhoneView:VerifyPhoneView
    
    init(verifyPhoneInteractor:VerifyPhoneInteractor, verifyPhoneView:VerifyPhoneView) {
        self.verifyPhoneInteractor = verifyPhoneInteractor
        self.verifyPhoneView = verifyPhoneView
        return
    }
    
    func sendCode(phoneNumber:String) {
        verifyPhoneInteractor.sendVerificationCode(phoneNumber: phoneNumber, verifyPresenterCallback: self)
    }
    
    func resendCode(phoneNumber:String) {
        verifyPhoneInteractor.resendVerificationCode(phoneNumber: phoneNumber)
    }
    
    func goToRegistration(phone: String) {
        
    }
    
    func goToProfile() {
        
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
