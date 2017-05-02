//
//  AirlinesListViewController.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import UIKit
import DATASource
import AlamofireImage

class AirlinesListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel:AirlinesListViewModel!
    
    var dataSource: DATASource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Airlines"
        
        guard let _ = viewModel else {
            fatalError("View model not injected!")
        }
        
        dataSource = DATASource(collectionView: self.collectionView,
                                    cellIdentifier: "AirlinesListCollectionViewCell",
                                    fetchRequest: self.viewModel.request,
                                    mainContext: self.viewModel.dataStack.mainContext,
                                    configuration: {
            cell, item, indexPath in
            guard let localCell = cell as? AirlinesListCollectionViewCell,
                    let localItem = item as? Airline
                else { return }
            localCell.nameLabel.text = localItem.name
                                        
            print("localItem.logoURL = \(localItem.logoURL)")
    
                                        
            let url = URL(string: "https://www.kayak.com" + localItem.logoURL!)!
            let placeholderImage = UIImage(named: "placeholder")!
                                        
            let filter = AspectScaledToFitSizeWithRoundedCornersFilter(
                size: localCell.logoImageView.frame.size,
                radius: 5.0
            )
                                        
            localCell.logoImageView.af_setImage(
                withURL: url,
                placeholderImage: placeholderImage,
                filter: filter
            )                          
        })

        collectionView.dataSource = dataSource
        
        self.viewModel.networkService.fetchItems{
            error in
            print("Finish!!! error = \(error)")
        }
    }
    
}


public struct AspectScaledToFitSizeWithRoundedCornersFilter: CompositeImageFilter {
    public init(size: CGSize, radius: CGFloat, divideRadiusByImageScale: Bool = false) {
        self.filters = [
            AspectScaledToFitSizeFilter(size: size),
            RoundedCornersFilter(radius: radius, divideRadiusByImageScale: divideRadiusByImageScale)
        ]
    }
    
    public let filters: [ImageFilter]
}
