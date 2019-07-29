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
}
