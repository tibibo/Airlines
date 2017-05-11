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
    
    var dataStack: DATAStack!
    
    func fetchItems(_ completion: @escaping (NSError?) -> Void) {
        Alamofire.request(Config.Backend.AirlinesURL).responseJSON { response in
            
            if case .failure(let error) = response.result {
                print("Can't connect to backend error = \(error)")
                return
            }
            
            guard let data = response.result.value as? [[String : Any]] else {
                print("Can't read data from the backend response.result.value = \(response.result.value)")
                return
            }
            
            Sync.changes(data, inEntityNamed: Constant.Entity.Airline, dataStack: self.dataStack) { error in
                completion(error)
            }
        }
    }
}
