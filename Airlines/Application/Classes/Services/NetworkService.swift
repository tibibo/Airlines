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

class NetworkService: NSObject {
    let airlinesURL = "https://www.kayak.com/h/mobileapis/directory/airlines"
    let dataStack: DATAStack
    
    required init(dataStack: DATAStack) {
        self.dataStack = dataStack
    }
    
    func fetchItems(_ completion: @escaping (NSError?) -> Void) {
        Alamofire.request(airlinesURL).responseJSON { response in
            let data = response.result.value as! [[String : Any]]
            
            Sync.changes(data, inEntityNamed: "Airlines", dataStack: self.dataStack) { error in
                completion(error)
            }
        }
    }
}
