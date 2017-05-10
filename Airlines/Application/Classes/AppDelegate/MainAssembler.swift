//
//  MainAssembler.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class MainAssembler {
    
    static var defaultContainer = {
        () -> Container in
        
        Container.loggingFunction = nil //To disable issue with resolved — see https://github.com/Swinject/Swinject/issues/218
        
        let container = Container()
        assembler = try! Assembler(assemblies: [
            //Modules
            AirlinesListAssembly(),
            AirlineDetailAssembly(),
            //Services
            ServicesAssembly()
            ],
                       container: container)
        resolver = assembler.resolver
        
        return container
        
    }()
    
    static var assembler:Assembler!
    static var resolver:Resolver!
    
    static var mainStoryBoard:SwinjectStoryboard = {
        return SwinjectStoryboard.create(name: "Main", bundle: nil, container: defaultContainer.synchronize())
    }()
    
}
