//
//  AirlinesListAssembly.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class AirlinesListAssembly: Assembly {
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(AirlinesListViewController.self) { (r, c) in
            c.viewModel = r.resolve(AirlinesListViewModel.self)
        }
        
        container.register(AirlinesListViewModel.self) { _ in AirlinesListViewModel()}
            .initCompleted { (r, c) in
                c.networkService = r.resolve(NetworkService.self)
                c.afterInit()
        }
    }
}
