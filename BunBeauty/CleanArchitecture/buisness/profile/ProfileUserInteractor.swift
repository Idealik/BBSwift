//
//  ProfileUserInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class ProfileUserInteractor: IProfileUserInteractor {
    
    private var userRepository:UserRepository

    init(userRepository:UserRepository) {
        self.userRepository = userRepository
    }
    
    
}
