//
//  AirlinesListViewController.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 01/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import UIKit
import DATASource

class AirlinesListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel:AirlinesListViewModel!
    
    var dataSource: DATASource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _ = viewModel else {
            fatalError("View model not injected!")
        }
        
        dataSource = DATASource(collectionView: self.collectionView,
                                    cellIdentifier: "AirlinesListCollectionViewCell",
                                    fetchRequest: self.viewModel.request,
                                    mainContext: self.viewModel.dataStack.mainContext,
                                    configuration: {
                                        cell, item, indexPath in
            guard let localCell = cell as? AirlinesListCollectionViewCell else { return }
            localCell.nameLabel.text = item.value(forKey: "name") as? String
        })

        collectionView.dataSource = dataSource
        
        self.viewModel.networkService.fetchItems{
            error in
            print("Finish!!! error = \(error)")
        }
    }
    
}

