//
//  MessageFirebase.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 28.08.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
import FirebaseDatabase
class MessageFirebase {
    
    
    func getMessageFromSnapshot(messageSnapshot: DataSnapshot) -> Message {
        
        var message = Message()
        message.id = messageSnapshot.key
        
        message.message = messageSnapshot.childSnapshot(forPath: Message.MESSAGE).value as! String
        message.time = messageSnapshot.childSnapshot(forPath: Message.TIME).value as! Int
        message.finishOrderTime = messageSnapshot.childSnapshot(forPath: Message.FINISH_ORDER_TIME_ID).value as? Int ?? 0
        message.type = messageSnapshot.childSnapshot(forPath: Message.TYPE).value as! Int
        message.ownerId = messageSnapshot.childSnapshot(forPath: Message.OWNER_ID).value as! String
        message.orderId = messageSnapshot.childSnapshot(forPath: Message.ORDER_ID).value as? String ?? ""

        return Message()
    }
}
