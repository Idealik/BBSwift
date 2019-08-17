//
//  User.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 15/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseDatabase
class User: IUser {
    private let USERS:String = "users"
    private let SERVICES:String = "services"
    private let WORKING_DAYS:String = "working days"
    private let WORKING_TIME:String = "working time"
    private let ORDERS:String = "orders"
    private let REVIEWS:String = "reviews"
    private let IS_CANCELED:String = "is canceled"
    private let USER_ID:String = "user id"
    private let TIME:String = "time"
    private let REVIEW_FOR_SERVICE:String = "review for service"
    private let REVIEW_FOR_USER:String = "review for user"
    private let RATING:String = "rating"
    private let REVIEW:String = "review"
    private let TYPE:String = "type"
    private let WORKER_ID:String = "worker id"
    private let WORKING_DAY_ID:String = "working day id"
    private let WORKING_TIME_ID:String = "working time id"
    private let SERVICE_ID:String = "service id"
    
    private var userId: String
    private var serviceId: String
    private var workingDaysId: String
    
    init(userId: String, serviceId: String, workingDaysId:String) {
        self.userId = userId
        self.serviceId = serviceId
        self.workingDaysId = workingDaysId
    }
    
    func makeOrder(workingTimeId: String) {
        let serviceOwnerId = getServiceOwnerId(workingTimeId: workingTimeId)
        let orderId = makeOrderForService(workingTimeId: workingTimeId, serviceOwnerId: serviceOwnerId)
        makeOrderForUser(orderId: orderId, workerId: serviceOwnerId, workingTimeId: workingTimeId)
    }
    
    private func makeOrderForService(workingTimeId:String, serviceOwnerId:String) -> String {
        var orderRef = Database.database().reference()
            .child(USERS)
            .child(serviceOwnerId)
            .child(SERVICES)
            .child(serviceId)
            .child(WORKING_DAYS)
            .child(workingDaysId)
            .child(WORKING_TIME)
            .child(workingTimeId)
            .child(ORDERS)
        let messageTime = WorkWithTimeApi.getDateInFormatYMDHS(date: Date())
        var items :Dictionary <String,Any> = [:]
        items.updateValue(false, forKey: IS_CANCELED)
        items.updateValue(userId, forKey: USER_ID)
        items.updateValue(messageTime, forKey: TIME)
        let orderId = orderRef.childByAutoId().key!
        orderRef = orderRef.child(orderId)
        orderRef.updateChildValues(items)
        
        addOrderInLocalStorage(orderId: orderId, timeId: workingTimeId, messageTime: messageTime)
        
        //review for service
        makeReview(orderRef: orderRef, type: REVIEW_FOR_SERVICE)
        return orderId
    }
    private func makeOrderForUser(orderId:String,  workerId:String, workingTimeId:String) {
        let orderRef = Database.database().reference()
            .child(USERS)
            .child(userId)
            .child(ORDERS)
            .child(orderId)
        
        var items :Dictionary <String,Any> = [:]
        items.updateValue(workerId, forKey: WORKER_ID)
        items.updateValue(serviceId, forKey: SERVICE_ID)
        items.updateValue(workingDaysId, forKey: WORKING_DAY_ID)
        items.updateValue(workingTimeId, forKey: WORKING_TIME_ID)
        orderRef.updateChildValues(items)
        
        makeReview(orderRef: orderRef, type: REVIEW_FOR_USER)
    }
    private func makeReview(orderRef:DatabaseReference, type:String) {
        let orderId = orderRef.childByAutoId().key!
        var reviewRef = orderRef.child(REVIEWS)
        let reviewId = reviewRef.childByAutoId().key!
        reviewRef = reviewRef.child(reviewId)
        var items :Dictionary <String,Any> = [:]
        items.updateValue(0, forKey: RATING)
        items.updateValue("", forKey: REVIEW)
        items.updateValue(type, forKey: TYPE)
        reviewRef.updateChildValues(items)
        
        addReviewInLocalStorage(orderId: orderId, reviewId: reviewId, type: type)
    }
    private func getServiceOwnerId(workingTimeId:String) -> String {
        return WorkWithLocalStorageApi.getSertviceCursorByTimeId(workingTimeId: workingTimeId).getUserId()
    }
    private func addReviewInLocalStorage(orderId:String, reviewId:String, type:String){
        let realm = DBHelper().getDBhelper()
        let reviewTable = TABLE_REVIEWS()
        
        reviewTable.KEY_ID = reviewId
        reviewTable.KEY_REVIEW_REVIEWS = ""
        reviewTable.KEY_RATING_REVIEWS = "0"
        reviewTable.KEY_TYPE_REVIEWS = type
        reviewTable.KEY_ORDER_ID_REVIEWS = orderId
        try! realm.write {
            realm.add(reviewTable)
        }
    }
    private func addOrderInLocalStorage(orderId:String, timeId:String, messageTime:String){
        let realm = DBHelper().getDBhelper()
        let orderTable = TABLE_ORDERS()
        orderTable.KEY_ID = orderId
        orderTable.KEY_USER_ID = userId
        orderTable.KEY_IS_CANCELED_ORDERS = "false"
        orderTable.KEY_WORKING_TIME_ID_ORDERS = timeId
        orderTable.KEY_MESSAGE_TIME_ORDERS = messageTime
        
        try! realm.write {
            realm.add(orderTable)
        }
        print("")
    }
}
