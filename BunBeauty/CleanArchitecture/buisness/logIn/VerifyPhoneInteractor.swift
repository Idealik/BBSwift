//
//  VerifyPhoneInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class VerifyPhoneInteractor {
    
    private var verifyPresenterCallback: VerifyPhonePresenterCallback?

    func sendVerificationCode(
        phoneNumber: String,
        verifyPresenterCallback: VerifyPhonePresenterCallback
        ) {
        self.verifyPresenterCallback = verifyPresenterCallback
        
        //verifyPhoneNumberApi.sendVerificationCode(phoneNumber, this)
    }
    
    
    func resendVerificationCode(phoneNumber: String) {
        //verifyPhoneNumberApi.resendVerificationCode(phoneNumber)
    }
    
    
    func checkCode(code: String) {
        //verifyPhoneNumberApi.checkCode(code, this)
    }
    
    
    func returnTooManyRequestsError() {
        //verifyPresenterCallback.showTooManyRequestsError()
    }
    
    func returnVerificationFailed() {
        //verifyPresenterCallback.showVerificationFailed()
    }
    
    func returnTooShortCodeError() {
        //verifyPresenterCallback.showTooShortCodeError()
    }
    
}
