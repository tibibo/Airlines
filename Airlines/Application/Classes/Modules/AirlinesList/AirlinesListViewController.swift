//
//  AirlinesListViewController.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import UIKit

class AirlinesListViewController: UIViewController {
    
    var viewModel:AirlinesListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _ = viewModel else {
            fatalError("View model not injected!")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

