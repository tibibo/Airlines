//
//  AirlineDetailAssembly.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 03/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import DATAStack

class AirlineDetailAssembly: Assembly {
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(AirlineDetailViewController.self) { (r, c) in
            c.viewModel = r.resolve(AirlineDetailViewModel.self)
        }
        
        container.register(AirlineDetailViewModel.self) { _ in AirlineDetailViewModel()}
            .initCompleted { (r, c) in
                c.dataStack = r.resolve(DATAStack.self)
        }
    }
}
