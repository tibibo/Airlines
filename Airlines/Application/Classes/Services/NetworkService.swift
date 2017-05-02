//
//  NetworkService.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import UIKit
import DATAStack
import Sync
import Alamofire

class NetworkService {
    
    let airlinesURL = "https://www.kayak.com/h/mobileapis/directory/airlines"
    
    var dataStack: DATAStack!
    
    func fetchItems(_ completion: @escaping (NSError?) -> Void) {
        Alamofire.request(airlinesURL).responseJSON { response in
            let data = response.result.value as! [[String : Any]]
            
            Sync.changes(data, inEntityNamed: "Airline", dataStack: self.dataStack) { error in
                completion(error)
            }
        }
    }
}
