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
    static func checkCurrentDay(date:String, serviceId:String) -> String {
        let realm = DBHelper().getDBhelper()
        //read element from databse
        let daysCursor = realm.objects(TABLE_WORKING_DAYS.self).filter("(KEY_SERVICE_ID_WORKING_DAYS = '" + serviceId + "') AND (KEY_DATE_WORKING_DAYS = '" + date + "')" )
        
        for dayElement in daysCursor{
            return dayElement.KEY_ID!
        }
        return "0"
    }
    
    static func hasSomeWork(dayId:String) -> Bool{
        let realm = DBHelper().getDBhelper()
        //read element from databse
        let timeCursor = realm.objects(TABLE_WORKING_TIME.self).filter("KEY_WORKING_DAYS_ID_WORKING_TIME = '" + dayId + "'" )
        
        for _ in timeCursor{
            return true
        }
        return false
    }
    
    static func checkCurrentTimeForWorker(workingDaysId:String, time:String) -> Bool {
        return false
    }
}
