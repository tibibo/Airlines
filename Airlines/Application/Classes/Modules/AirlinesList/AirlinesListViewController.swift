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
    
    private var currentFilter:FilterValueFormat = .All
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Airlines"
        
        guard let _ = viewModel else {
            fatalError("View model not injected!")
        }
        
        let key = String(describing: AirlinesListCollectionViewCell.self)
        
        dataSource = DATASource(collectionView: self.collectionView!,
                                    cellIdentifier: key,
                                    fetchRequest: self.viewModel.request,
                                    mainContext: self.viewModel.dataStack.mainContext,
                                    configuration: collectionViewConfiguration)

        collectionView!.dataSource = dataSource
        
        self.viewModel.networkService.fetchItems{
            error in
            print("Finish!!! error = \(error)")
        }
    }
    
    private func collectionViewConfiguration(_ cell: UICollectionViewCell, _ item: NSManagedObject, _ indexPath: IndexPath) -> () {
        
        guard let localCell = cell as? AirlinesListCollectionViewCell,
            let localItem = item as? Airline
            else { return }
        localCell.nameLabel.text = localItem.name!
        
        let url = URL(string: Config.Backend.MainURL + localItem.logoURL!)!
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
        
        localCell.favoriteImageView.isHidden = !(localItem.isFavorite && self.currentFilter == .All)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == Constant.Segue.showDetailViewController {
            
            guard let selected = collectionView?.indexPathsForSelectedItems?.first,
                let airline = dataSource.object(selected) as? Airline else {
                fatalError("No airline available")
            }
            
            guard let detailVC = segue.destination as? AirlineDetailViewController else {
                fatalError("Wrong destination view controller, waiting AirlineDetailViewController")
            }
            
            detailVC.viewModel.airline = airline
        }
    }
    
    @IBAction func applyFilter(segmentedControl: UISegmentedControl) {
    
        guard let filterValue = FilterValueFormat(rawValue: segmentedControl.selectedSegmentIndex) else {
            return
        }
        
        switch filterValue {
        case .All :
            self.currentFilter = .All
            self.dataSource.predicate = nil
        case .Favorite :
            self.currentFilter = .Favorite
            self.dataSource.predicate = NSPredicate(format: "isFavorite == true")
        }
    }
    
    private enum FilterValueFormat:Int {
        case All
        case Favorite
    }
}

