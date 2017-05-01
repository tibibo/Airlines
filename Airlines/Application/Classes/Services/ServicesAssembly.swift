//
//  ServicesAssembly.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import DATAStack

class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(NetworkService.self) { r in
            return NetworkService(dataStack: r.resolve(DATAStack.self)!)
            }.inObjectScope(.container)
        
        container.register(DATAStack.self) { r in
            return DATAStack(modelName: "Airlines")
            }.inObjectScope(.container)
    }
}
