//
//  CreationServiceServiceInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 01.08.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
class CreationServiceServiceInteractor: ICreationServiceServiceInteractor {
    
    private var creationServicePresenterCallback: CreationServicePresenterCallback?
    
    func addService(service: Service, creationServicePresenterCallback: CreationServicePresenterCallback) {
        self.creationServicePresenterCallback = creationServicePresenterCallback
    }
    
    
}
