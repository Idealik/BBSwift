//
//  IWorker.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 03/08/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
protocol IWorker {
    func addWorkingDay(date:String) -> String
    func addTime(workingDaysId:String, workingHours: [String]) -> Void
    func deleteTime(workingDaysId:String, removedHours: [String]) -> Void

}
