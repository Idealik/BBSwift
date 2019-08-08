//
//  LoadingGuestServiceData.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 06/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseDatabase
class LoadingGuestServiceData{
    private static let DATE:String = "date"
    private static let TIME:String = "time"
    
    static func addServiceInLocalStorage(service:ServiceEntity) {
        let realm = DBHelper().getDBhelper()
        //read element from databse
        let serviceTable = realm.objects(TABLE_SERVICES.self).filter("KEY_ID = %@", service.getId())
        
        try! realm.write {
            serviceTable.setValue(service.getId(), forKey: "KEY_ID")
            serviceTable.setValue(service.getDescription(), forKey: "KEY_DESCRIPTION_SERVICES")
            serviceTable.setValue(service.getCost(), forKey: "KEY_MIN_COST_SERVICES")
            serviceTable.setValue(String(service.getCountOfRates()), forKey: "KEY_COUNT_OF_RATES_SERVICES")
            serviceTable.setValue(String(service.getAverageRating()), forKey: "KEY_RATING_SERVICES")
            serviceTable.setValue(service.getAddress(), forKey: "KEY_ADDRESS_SERVICES")
            serviceTable.setValue(service.getUserId(), forKey: "KEY_USER_ID_SERVICES")
            
            //serviceTable.KEY_IS_PREMIUM_SERVICES = service.getIsPremium()
            
        }
    }
    
    static func addWorkingDaysInLocalStorage(workingDaySnapshot:DataSnapshot, serviceId:String) {
        let realm = DBHelper().getDBhelper()
        let workingDayId = workingDaySnapshot.key
        let date = workingDaySnapshot.childSnapshot(forPath: DATE).value as? String
        if WorkWithLocalStorageApi.hasSomeData(table: TABLE_WORKING_DAYS.self, keyId:workingDayId)
        {
            //update
            let workingDayTable = realm.objects(TABLE_WORKING_DAYS.self).filter("KEY_ID = %@", workingDayId)
            try! realm.write {
                workingDayTable.setValue(workingDayId, forKey: "KEY_ID")
                workingDayTable.setValue(date, forKey: "KEY_DATE_WORKING_DAYS")
                workingDayTable.setValue(serviceId, forKey: "KEY_SERVICE_ID_WORKING_DAYS")                
            }
        }
        else{
            //new
            let workingDaysTable = TABLE_WORKING_DAYS()
            workingDaysTable.KEY_ID = workingDayId
            workingDaysTable.KEY_DATE_WORKING_DAYS = date
            workingDaysTable.KEY_SERVICE_ID_WORKING_DAYS = serviceId
            
            try! realm.write {
                realm.add(workingDaysTable)
            }
            
        }
    }
    static func addTimeInLocalStorage(timeSnapshot:DataSnapshot, workingDayId:String) {
        let realm = DBHelper().getDBhelper()
        let timeId = timeSnapshot.key
        let time = timeSnapshot.childSnapshot(forPath: TIME).value as? String
        if WorkWithLocalStorageApi.hasSomeData(table: TABLE_WORKING_TIME.self, keyId:timeId)
        {
            //update
            let timeTable = realm.objects(TABLE_WORKING_TIME.self).filter("KEY_ID = %@", timeId)
            try! realm.write {
                timeTable.setValue(timeId, forKey: "KEY_ID")
                timeTable.setValue(time, forKey: "KEY_TIME_WORKING_TIME")
                timeTable.setValue(workingDayId, forKey: "KEY_WORKING_DAYS_ID_WORKING_TIME")
            }
        }
        else{
            let timeTable = TABLE_WORKING_TIME()
            timeTable.KEY_ID = timeId
            timeTable.KEY_TIME_WORKING_TIME = time
            timeTable.KEY_WORKING_DAYS_ID_WORKING_TIME = workingDayId
            
            try! realm.write {
                realm.add(timeTable)
            }
            
        }
    }
    
    static func deleteTimeFromLocalStorage(timeId:String) {
        let realm = DBHelper().getDBhelper()
        let timeCursor = realm.objects(TABLE_WORKING_TIME.self).filter("KEY_ID == %@", timeId)
        for time in timeCursor{
            try! realm.write {
                realm.delete(time)
            }
        }
    }
}
