//
//  Worker.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 03/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class Worker: IWorker {
    private let USERS:String = "users"
    private let SERVICES:String = "services"
    private let WORKING_DAYS:String = "working days"
    private let WORKING_TIME:String = "working time"

    private let DATE:String = "date"
    private let TIME:String = "time"

    var userId: String
    var serviceId: String
    
    init(userId: String, serviceId: String) {
        self.userId = userId
        self.serviceId = serviceId
    }
    
    func addWorkingDay(date: String) -> String {
        var dateRef = Database.database().reference()
            .child(USERS)
            .child(userId)
            .child(SERVICES)
            .child(serviceId)
            .child(WORKING_DAYS)
        
        var items :Dictionary <String,Any> = [:]
        items.updateValue(date, forKey: DATE)
        let dayId = dateRef.childByAutoId().key!
        dateRef = dateRef.child(dayId)
        dateRef.updateChildValues(items)
        addDateInLocalStorage(serviceId: serviceId, dayId: dayId, date: date)
        return dayId
    }
    
    func addTime(workingDaysId: String, workingHours: [String]) {
        for time in workingHours{
            if !WorkWithLocalStorageApi.checkCurrentTimeForWorker(workingDaysId: workingDaysId, time: time){
                // free time
                var timeRef = Database.database().reference()
                    .child(USERS)
                    .child(userId)
                    .child(SERVICES)
                    .child(serviceId)
                    .child(WORKING_DAYS)
                    .child(workingDaysId)
                    .child(WORKING_TIME)
                
                var items :Dictionary <String,Any> = [:]
                items.updateValue(time, forKey: TIME)
                let timeId = timeRef.childByAutoId().key!
                timeRef = timeRef.child(timeId)
                timeRef.updateChildValues(items)
                addTimeInLocalStorage(timeId: timeId, time: time, workingDaysId: workingDaysId)
            }
        }
    }
    
    func deleteTime(workingDaysId: String, removedHours: [String]) {
        print("")
    }
    private func addDateInLocalStorage(serviceId:String, dayId:String, date:String){
        let realm = DBHelper().getDBhelper()
        let workingDaysTable = TABLE_WORKING_DAYS()
        workingDaysTable.KEY_ID = dayId
        workingDaysTable.KEY_DATE_WORKING_DAYS = date
        workingDaysTable.KEY_SERVICE_ID_WORKING_DAYS = serviceId
        
        try! realm.write {
            realm.add(workingDaysTable)
        }
    }
    
    private func addTimeInLocalStorage(timeId:String, time:String, workingDaysId:String){
        let realm = DBHelper().getDBhelper()
        let workingTimeTable = TABLE_WORKING_TIME()
        workingTimeTable.KEY_ID = timeId
        workingTimeTable.KEY_TIME_WORKING_TIME = time
        workingTimeTable.KEY_WORKING_DAYS_ID_WORKING_TIME = workingDaysId
        
        try! realm.write {
            realm.add(workingTimeTable)
        }
    }
}
