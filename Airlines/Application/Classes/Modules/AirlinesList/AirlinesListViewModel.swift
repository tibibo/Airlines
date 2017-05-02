//
//  AirlinesListViewModel.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import Foundation
import CoreData
import DATAStack

class AirlinesListViewModel {

    var networkService:NetworkService!
    
    var dataStack: DATAStack!
    
    func afterInit() {
        guard let _ = networkService else {
            fatalError("networkHelper not injected!")
        }
    }
    
    lazy var request: NSFetchRequest<NSFetchRequestResult> = {
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Airline")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }()
    
}
