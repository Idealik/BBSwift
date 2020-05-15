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
    private let SERVICE_ID:String = "service id"
    private let WORKER_ID:String = "worker id"
    private let USER_ID:String = "user id"
    private let WORKING_DAY_ID:String = "working day id"
    private let WORKING_TIME_ID:String = "working time id"
    private let WORKING_DAYS:String = "working days"
    private let WORKING_TIME:String = "working time"
    private let DATE:String = "date"
    private let TIME:String = "time"
    private let IS_CANCELED:String = "is canceled"
    private var counter = 0
    private let ORDERS:String = "orders"

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
                    self.loadMyOrders(ordersSpanshot: (userSnapshot as! DataSnapshot).childSnapshot(forPath: self.ORDERS), _myPhoneNumber: _myPhoneNumber, _context: _context, _controller: _controller)
                    
                }
            }
        }
    }
    private func loadMyOrders(ordersSpanshot:DataSnapshot, _myPhoneNumber:String, _context:UIStoryboard, _controller:UIViewController){
        if ordersSpanshot.childrenCount == 0{
            return
        }
        let childrenCount = ordersSpanshot.childrenCount
        for order in ordersSpanshot.children{
            let orderId = (order as! DataSnapshot).key
            let workerId  = (order as! DataSnapshot).childSnapshot(forPath: WORKER_ID).value as! String
            let serviceId = (order as! DataSnapshot).childSnapshot(forPath: SERVICE_ID).value as! String
            let workingDayId = (order as! DataSnapshot).childSnapshot(forPath: WORKING_DAY_ID).value as! String
            let workingTimeId = (order as! DataSnapshot).childSnapshot(forPath: WORKING_TIME_ID).value as! String
            
            let serviceReference = Database.database().reference()
                .child(USERS)
            .child(workerId)
            .child(SERVICES)
            .child(serviceId)
            
            serviceReference.observeSingleEvent(of: .value) { (serviceSnapshot) in
                let daySnapshot = serviceSnapshot.childSnapshot(forPath: self.WORKING_DAYS)
                    .childSnapshot(forPath: workingDayId)
                
                if self.isActualOrder(daySnapshot: daySnapshot, timeId: workingTimeId, orderId: orderId){
                    self.addWorkingDaysInLocalStorage(daySnapshot: daySnapshot, serviceId: serviceId)
                    let timeSnapshot = daySnapshot.childSnapshot(forPath: self.WORKING_TIME)
                        .childSnapshot(forPath: workingTimeId)
                    self.addTimeInLocalStorage(timeSnapshot: timeSnapshot, workingDayId: workingDayId)
                    let orderSnapshot = timeSnapshot.childSnapshot(forPath: self.ORDERS)
                        .childSnapshot(forPath: orderId)
                    self.addOrderInLocalStorage(orderSnapshot: orderSnapshot, workingTimeId: workingTimeId)
                    let serviceName = serviceSnapshot.childSnapshot(forPath: self.NAME).value as! String
                    self.addServiceInLocalStorage(serviceId: serviceId, serviceName: serviceName, workerId:workerId )
                    print("HIII")
                }
                
                self.counter+=1
                if self.counter == childrenCount{
                    self.goToProfile(_myPhoneNumber: _myPhoneNumber, _context: _context, _controller: _controller)
                }
                
            }
        }
    }
    private func isActualOrder(daySnapshot:DataSnapshot, timeId:String, orderId:String) ->Bool{
        
        let date = daySnapshot.childSnapshot(forPath: DATE).value as! String
        let time = daySnapshot.childSnapshot(forPath: WORKING_TIME).childSnapshot(forPath: timeId).childSnapshot(forPath: TIME).value as! String
        
        let isCanceled = daySnapshot.childSnapshot(forPath: WORKING_TIME)
            .childSnapshot(forPath: timeId)
            .childSnapshot(forPath: ORDERS)
            .childSnapshot(forPath: orderId)
            .childSnapshot(forPath: IS_CANCELED).value as! Bool
        let commonDate = date + " " + time + ":00"

        let orderDate = WorkWithTimeApi.getMillisecondsStringDateYMDHMS(date: commonDate) + 3600
        let sysdate = WorkWithTimeApi.getSysadateInt()
        if orderDate < sysdate || isCanceled {
            return false
        }
        return true
    }
    
    private func addWorkingDaysInLocalStorage(daySnapshot:DataSnapshot, serviceId:String) {
        let realm = DBHelper().getDBhelper()
        let workingDayId = daySnapshot.key
        let date = daySnapshot.childSnapshot(forPath: DATE).value as? String
        let workingDaysTable = TABLE_WORKING_DAYS()
        workingDaysTable.KEY_ID = workingDayId
        workingDaysTable.KEY_DATE_WORKING_DAYS = date
        workingDaysTable.KEY_SERVICE_ID_WORKING_DAYS = serviceId
        
        try! realm.write {
            realm.add(workingDaysTable)
        }
    }
    
    private func addTimeInLocalStorage(timeSnapshot:DataSnapshot, workingDayId:String) {
        let realm = DBHelper().getDBhelper()
        let timeId = timeSnapshot.key
        let timeTable = TABLE_WORKING_TIME()
        let time = timeSnapshot.childSnapshot(forPath: TIME).value as! String
        timeTable.KEY_ID = timeId
        timeTable.KEY_TIME_WORKING_TIME = time
        timeTable.KEY_WORKING_DAYS_ID_WORKING_TIME = workingDayId
        
        try! realm.write {
            realm.add(timeTable)
        }
    }
    
    private func addOrderInLocalStorage(orderSnapshot:DataSnapshot, workingTimeId:String) {
        let realm = DBHelper().getDBhelper()
        let orderId = orderSnapshot.key
        let orderTable = TABLE_ORDERS()
        let userId = orderSnapshot.childSnapshot(forPath: USER_ID).value as! String
        
        orderTable.KEY_ID = orderId
        orderTable.KEY_USER_ID = userId
        orderTable.KEY_IS_CANCELED_ORDERS = "false"
        orderTable.KEY_WORKING_TIME_ID_ORDERS = workingTimeId
        try! realm.write {
            realm.add(orderTable)
        }
    }
    
    private func addServiceInLocalStorage(serviceId:String, serviceName:String, workerId:String) {
        let realm = DBHelper().getDBhelper()
        let serviceTable = TABLE_SERVICES()
        
        serviceTable.KEY_ID = serviceId
        serviceTable.KEY_NAME_SERVICES = serviceName
        serviceTable.KEY_USER_ID_SERVICES = workerId
        
        try! realm.write {
            realm.add(serviceTable)
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
