//
//  Dialog.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
struct Dialog {
    var id: String = ""
    var ownerId: String = ""
    var isChecked: Bool = true
    var user: User = User()
    var lastMessage: Message =  Message()
    
    static let DIALOGS = "dialogs"
    static let COMPANION_DIALOG = "companion dialog"
    static let DIALOG = "dialog"
    static let IS_CHECKED = "is checked"
    static let COMPANION_ID = "companion id"
    
}
