//
//  ServiceRepository.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 01.08.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class ServiceRepository: IServiceRepository {
    
    var serviceFirebase:ServiceFirebase?

    init(serviceFirebase:ServiceFirebase) {
        self.serviceFirebase = serviceFirebase
    }
    
    func insert(service: Service) {
        var finaService = service
        finaService.id = serviceFirebase?.getIdForNew(service: service) ?? ""
        serviceFirebase?.insert(service: finaService)
    }
    
    public static func getInstance() -> ServiceRepository {
        return ServiceRepository(serviceFirebase: ServiceFirebase())
    }
    
}
