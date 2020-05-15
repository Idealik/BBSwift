//
//  WorkWithLocalStorageApi.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift
class WorkWithLocalStorageApi: Object {
    static func checkCurrentDay(date:String, serviceId:String) -> String? {
        let realm = DBHelper().getDBhelper()
        //read element from databse
        let daysCursor = realm.objects(TABLE_WORKING_DAYS.self).filter("(KEY_SERVICE_ID_WORKING_DAYS = '" + serviceId + "') AND (KEY_DATE_WORKING_DAYS = '" + date + "')" )
        
        for dayElement in daysCursor{
            return dayElement.KEY_ID!
        }
        return nil
    }
    
    static func hasSomeWork(dayId:String) -> Bool{
        let realm = DBHelper().getDBhelper()
        //read element from databse
        let timeCursor = realm.objects(TABLE_WORKING_TIME.self).filter("KEY_WORKING_DAYS_ID_WORKING_TIME = %@", dayId)
        
        for _ in timeCursor{
            return true
        }
        return false
    }
    
    static func checkCurrentTimeForWorker(workingDaysId:String, time:String) -> Bool {
        
        let realm = DBHelper().getDBhelper()
        let timeCursor = realm.objects(TABLE_WORKING_TIME.self).filter("(KEY_TIME_WORKING_TIME = '" + time + "') AND (KEY_WORKING_DAYS_ID_WORKING_TIME = '" + workingDaysId + "')" )
        
        for _ in timeCursor{
            return true
        }
        
        return false
    }
    
    static func hasSomeData(table:Object.Type, keyId:String) -> Bool {
        
        let realm = DBHelper().getDBhelper()
        let timeCursor = realm.objects(table).filter("KEY_ID = %@" , keyId)
        
        for _ in timeCursor{
            return true
        }
        
        return false
    }
    
    static func getWorkingTimeId(time:String, workingDaysId:String) -> String{
        let realm = DBHelper().getDBhelper()
        let timeCursor = realm.objects(TABLE_WORKING_TIME.self).filter("KEY_TIME_WORKING_TIME == %@ AND KEY_WORKING_DAYS_ID_WORKING_TIME == %@  " , time, workingDaysId)
        for time in timeCursor{
            return time.KEY_ID!
        }
        return ""
    }
    //??
    static func getSertviceCursorByTimeId(workingTimeId:String) -> ServiceEntity {
        let realm = DBHelper().getDBhelper()
        let timeCursor = realm.objects(TABLE_WORKING_TIME.self).filter("KEY_ID = %@" , workingTimeId)
        //get workingDaysId
        let workingDaysId = timeCursor[0].KEY_WORKING_DAYS_ID_WORKING_TIME!
        let workingDaysCursor = realm.objects(TABLE_WORKING_DAYS.self).filter("KEY_ID = %@" , workingDaysId)
        //get serviceId
        let serviceId = workingDaysCursor[0].KEY_SERVICE_ID_WORKING_DAYS!
        
        let serviceCursor = realm.objects(TABLE_SERVICES.self).filter("KEY_ID = %@" , serviceId)

        let service = ServiceEntity()
        service.setUserId(_userId: serviceCursor[0].KEY_USER_ID_SERVICES!)
        service.setName(_name: serviceCursor[0].KEY_NAME_SERVICES!)
        return service
    }
}
