//
//  AirlinesListViewModel.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import Foundation

class AirlinesListViewModel {

    var networkService:NetworkService!
    
    func afterInit() {
        guard let _ = networkService else {
            fatalError("networkHelper not injected!")
        }
    }
    
}
