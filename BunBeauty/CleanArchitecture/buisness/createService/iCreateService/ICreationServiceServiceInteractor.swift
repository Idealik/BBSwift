//
//  ICreationServiceServiceInteractor.swift
//  BunBeauty
//
//  Created by Марк Шавловский on 01.08.2020.
//  Copyright © 2020 BunBeauty. All rights reserved.
//

import Foundation
protocol ICreationServiceServiceInteractor {
    func addService(service:Service, creationServicePresenterCallback:CreationServicePresenterCallback)
}