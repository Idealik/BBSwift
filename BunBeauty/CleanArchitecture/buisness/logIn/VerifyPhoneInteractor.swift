//
//  VerifyPhoneInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 07.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class VerifyPhoneInteractor: GetUserCallback {
    
    private var userRepository:UserRepository
    private var verifyPresenterCallback: VerifyPhonePresenterCallback?
    private var userPhone:String = ""

    init(userRepository:UserRepository) {
        self.userRepository = userRepository
    }
    
    func checkUser(
        phoneNumber: String,
        verifyPresenterCallback: VerifyPhonePresenterCallback
    ) {
        self.verifyPresenterCallback = verifyPresenterCallback
        userPhone = phoneNumber
        userRepository.getByPhoneNumber(
            userPhone: phoneNumber,
            getUserCallback:self)
    }
    
    func returnElement(element: User?) {
        
        if(element != nil){
            if element?.name != ""{
                verifyPresenterCallback?.goToProfile(user: element!)
            }else{
                verifyPresenterCallback?.goToRegistration(phone:userPhone)
            }
        }else{
            verifyPresenterCallback?.goToRegistration(phone: userPhone)
            
        }
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
