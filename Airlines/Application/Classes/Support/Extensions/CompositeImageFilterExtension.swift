//
//  CompositeImageFilterExtension.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 10/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import UIKit
import AlamofireImage

public struct AspectScaledToFitSizeWithRoundedCornersFilter: CompositeImageFilter {
    public init(size: CGSize, radius: CGFloat, divideRadiusByImageScale: Bool = false) {
        self.filters = [
            AspectScaledToFitSizeFilter(size: size),
            RoundedCornersFilter(radius: radius, divideRadiusByImageScale: divideRadiusByImageScale)
        ]
    }
    
    public let filters: [ImageFilter]
}
