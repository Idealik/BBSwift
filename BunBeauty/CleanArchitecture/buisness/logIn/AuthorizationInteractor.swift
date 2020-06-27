//
//  AuthorizationInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 15.05.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseAuth
class AuthorizationInteractor: GetUserCallback {
    
    private var authorizationPresenterCallback: AuthorizationPresenterCallback?
    var userRepository:UserRepository
    
    init(userRepository:UserRepository) {
        self.userRepository = userRepository
    }
    
    func defaultAuthorize(authorizationPresenterCallback: AuthorizationPresenterCallback) {
        self.authorizationPresenterCallback = authorizationPresenterCallback
        
        if (Auth.auth().currentUser != nil) {
            userRepository.getByPhoneNumber(
                userPhone: Auth.auth().currentUser!.phoneNumber!,
                getUserCallback:self)
        } else {
            authorizationPresenterCallback.showViewOnScreen()
        }
    }
    
    func returnElement(element: User?) {
        if(element != nil){
            if element?.name != ""{
                authorizationPresenterCallback?.goToProfile(user: element!)
            }else{
                authorizationPresenterCallback?.goToRegistration(phone: element!.phone)
            }
        }else{
            authorizationPresenterCallback?.showViewOnScreen()
        }
    }
    
    func authorize(phone:String,authorizationPresenterCallback: AuthorizationPresenterCallback ){
        
        if (isPhoneCorrect(phone: phone)) {
            authorizationPresenterCallback.goToVerifyPhone(phone: phone)
        } else {
            authorizationPresenterCallback.setPhoneError()
        }
        
    }
    func isPhoneCorrect(phone: String)-> Bool {
        return phone.count == 12
    }
}
