//
//  CreationServiceServiceInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 01.08.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class CreationServiceServiceInteractor: ICreationServiceServiceInteractor, InsertServiceCallback {
 
    
    private var creationServicePresenterCallback: CreationServicePresenterCallback?
    private let serviceRepository:ServiceRepository
    
    init(serviceRepository:ServiceRepository) {
        self.serviceRepository = serviceRepository
    }
    
    func addService(service: Service, creationServicePresenterCallback: CreationServicePresenterCallback) {
        self.creationServicePresenterCallback = creationServicePresenterCallback
        serviceRepository.insert(service: service, insertServiceCallback:self)
    }
    
    func returnCreatedCallback(obj: Service) {
         
     }
     
}
