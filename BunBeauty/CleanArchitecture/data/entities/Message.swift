//
//  Message.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
struct Message {
    var id: String = ""
    var dialogId: String = ""
    var userId: String = ""
    var message: String = ""
    var orderId: String = ""
    var ownerId: String = ""
    var time: Int = 0
    var type: Int = 0
    var finishOrderTime: Int = 0

    static let MESSAGES = "messages"
    static let MESSAGE = "message"
    static let TYPE = "type"
    static let TEXT_MESSAGE_STATUS = 0
    static let USER_REVIEW_MESSAGE_STATUS = 1
    static let SERVICE_REVIEW_MESSAGE_STATUS = 2
    static let TIME = "time"
    static let ORDER_ID = "order id"
    static let OWNER_ID = "owner id"
    static let FINISH_ORDER_TIME_ID = "finish order time"

}
