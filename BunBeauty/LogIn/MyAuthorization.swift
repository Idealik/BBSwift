//
//  MyAuthorization.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 08/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyAuthorization {
    private let PHONE:String = "phone"
    private let USERS:String = "users"
    private let NAME:String = "name"
    private let SERVICES:String = "services"

    func authorizeUser(_myPhoneNumber:String, _context:UIStoryboard, _controller:UIViewController) {
        
        let ref = Database.database().reference()
            .child(USERS)
            .queryOrdered(byChild: PHONE)
            .queryEqual(toValue : _myPhoneNumber)
        
        ref.observeSingleEvent(of: .value) { (usersSnapshot) in
            if(usersSnapshot.childrenCount == 0){
                self.goToRegistration(_myPhoneNumber: _myPhoneNumber,_context: _context,_controller:_controller)
            }
            else{
                let userSnapshot = usersSnapshot.children.nextObject()
                let name = (userSnapshot! as AnyObject).childSnapshot(forPath: self.NAME).value
                if(name is NSNull){
                    self.goToRegistration(_myPhoneNumber: _myPhoneNumber,_context: _context,_controller:_controller)
                }
                else{
                    // clear DB
                    let realm = DBHelper()
                    realm.deleteDB(_realm: realm.getDBhelper())
                    //LoadProfileData.loadUserInfo
                    LoadingProfileData.loadUserInfo(userSnapshot: userSnapshot as! DataSnapshot, localDatabse: realm.getDBhelper())
                    let userId = (userSnapshot as AnyObject).key!
                    //загрузка сервисов
                    LoadingProfileData.loadUserServices(servicesSnapshot: (userSnapshot as AnyObject).childSnapshot(forPath: self.SERVICES), userId:userId)
                    //later
                    //загрузка подписчиков
                    
                    //загрузка ордеров
                    self.goToProfile(_myPhoneNumber: _myPhoneNumber, _context: _context, _controller: _controller)
                    
                }
            }
        }
    }
    private func goToRegistration(_myPhoneNumber:String, _context:UIStoryboard, _controller:UIViewController) {
        let  registrationVC = _context.instantiateViewController(withIdentifier: "Registration") as! Registration
        registrationVC.myPhoneNumber = _myPhoneNumber
        _controller.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    private func goToProfile(_myPhoneNumber:String, _context:UIStoryboard, _controller:UIViewController) {
        let  registrationVC = _context.instantiateViewController(withIdentifier: "Profile") as! Profile
        _controller.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
}
