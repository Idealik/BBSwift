//
//  ProfileServiceInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 30.07.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class ProfileServiceInteractor:IProfileServiceInteractor {
    private var serviceRepository:ServiceRepository
    
    init(serviceRepository:ServiceRepository) {
        self.serviceRepository = serviceRepository
    }

}
