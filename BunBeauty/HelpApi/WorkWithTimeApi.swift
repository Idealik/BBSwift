//
//  WorkWithTimeApi.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 28/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
class WorkWithTimeApi {
    static func getDateInFormatYMDHS(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    static func getDateInFormatYMD(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    static func getSysadateInt() -> Double{
        let timeInSeconds: TimeInterval = Date().timeIntervalSince1970
        return timeInSeconds
    }
    static func getMillisecondsStringDateYMD(date:String) -> Double {
        print(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let curDate = formatter.date(from: date)
        let timeInSeconds: TimeInterval = curDate?.timeIntervalSince1970 ?? 0
        print(timeInSeconds)
        return timeInSeconds
    }
    
    static func getMillisecondsStringDateYMDHMS(date:String) -> Double {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let curDate = formatter.date(from: date)
        let timeInSeconds: TimeInterval = curDate?.timeIntervalSince1970 ?? 0
        print(timeInSeconds)
        return timeInSeconds
    }
    
    static func getDateInFormatDM(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let month = monthToString(month: formatter.string(from: date))
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        return  day + "\n" + month
    }
    
    private static func monthToString(month:String) -> String{
        switch month {
        case "01":
            return "янв"
        case "02":
            return "фев"
        case "03":
            return "мар"
        case "04":
            return "апр"
        case "05":
            return "май"
        case "06":
            return "июня"
        case "07":
            return "июля"
        case "08":
            return "авг"
        case "09":
            return "сен"
        case "10":
            return "окт"
        case "11":
            return "ноя"
        case "12":
            return "дек"
        default:
            return ""
        }
    }
    static func monthToNumber(month:String) -> String{
        switch month {
        case "янв":
            return "01"
        case "фев":
            return "02"
        case "мар":
            return "03"
        case "апр":
            return "04"
        case "май":
            return "05"
        case "июня":
            return "06"
        case "июля":
            return "07"
        case "авг":
            return "08"
        case "сен":
            return "09"
        case "окт":
            return "10"
        case "ноя":
            return "11"
        case "дек":
            return "12"
        default:
            return ""
        }
    }
}
