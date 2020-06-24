//
//  AuthorizationInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 15.05.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseAuth
class AuthorizationInteractor {
    
    private var authorizationPresenterCallback: AuthorizationPresenterCallback?
    
    func defaultAuthorize(authorizationPresenterCallback: AuthorizationPresenterCallback) {
        self.authorizationPresenterCallback = authorizationPresenterCallback
        
        if (Auth.auth().currentUser != nil) {
//            userRepository.getByPhoneNumber(
//                FirebaseAuth.getInstance().currentUser!!.phoneNumber!!,
//                this,
//                true
//            )
        } else {
            authorizationPresenterCallback.showViewOnScreen()
        }
    }
    
    /*
     
     
     override fun returnUsers(users: List<User>) {
     if (users.isNotEmpty() && users.first().name.isNotEmpty()) {
     authorizationPresenterCallback.goToProfile()
     return
     }
     
     if (FirebaseAuth.getInstance().currentUser == null) {
     authorizationPresenterCallback.showViewOnScreen()
     return
     } else {
     authorizationPresenterCallback.goToRegistration(getCurrentFbUser()!!.phoneNumber!!)
     }
     }
     
     override fun authorize(
     phone: String,
     authorizationPresenterCallback: AuthorizationPresenterCallback
     ) {
     if (isPhoneCorrect(phone.trim())) {
     authorizationPresenterCallback.goToVerifyPhone(phone)
     } else {
     authorizationPresenterCallback.setPhoneError()
     }
     }
     
    
     fun isPhoneCorrect(phone: String): Boolean {
     return phone.length == 12
     }
     */
}
