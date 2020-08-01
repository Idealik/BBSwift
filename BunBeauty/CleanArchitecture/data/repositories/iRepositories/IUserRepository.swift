//
//  IUserRepository.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 24.06.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation

protocol IUserRepository {
    func insert(user:User)
    func update(user:User)
}
