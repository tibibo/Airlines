//
//  AirlineDetailViewController.swift
//  Airlines
//
//  Created by Vladimir Drapalyuk on 03/05/2017.
//  Copyright © 2017 Tibibo, s.r.o. All rights reserved.
//

import UIKit
import DATASource
import AlamofireImage

class AirlineDetailViewController: UIViewController {
    
    var viewModel:AirlineDetailViewModel!
    
    @IBOutlet weak public var logoImageView: UIImageView!
    @IBOutlet weak public var nameLabel: UILabel!
    @IBOutlet weak public var phoneLabel: UILabel!
    @IBOutlet weak public var siteButton: UIButton!
    @IBOutlet weak public var favoriteSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Airlines"
        
        guard let _ = viewModel else {
            fatalError("View model not injected!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshUI()
    }
    
    func refreshUI() {
        
        guard let airline = viewModel.airline else {
            return
        }
        
        nameLabel.text = airline.name
        phoneLabel.text = airline.phone
        siteButton.setTitle(airline.site, for: .normal)
        
        
        let url = URL(string: "https://www.kayak.com" + airline.logoURL!)!
        let placeholderImage = UIImage(named: "placeholder")!
        
        let filter = AspectScaledToFitSizeWithRoundedCornersFilter(
            size: logoImageView.frame.size,
            radius: 5.0
        )
        
        logoImageView.af_setImage(
            withURL: url,
            placeholderImage: placeholderImage,
            filter: filter
        )
        
        favoriteSwitch.isOn = airline.isFavorite
    }
    
    @IBAction func showSite() {
        guard let site = viewModel.airline?.site,
            let url = URL(string: "https://" + site),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func updateIsFavorite(localSwitch: UISwitch) {
        guard let airline = viewModel.airline else {
                return
        }
        
        self.viewModel.dataStack.performInNewBackgroundContext { (context) in
            
            guard let localAirline = context.object(with: airline.objectID) as? Airline else {
                return
            }
            localAirline.isFavorite = localSwitch.isOn
            do {
                try context.save()
            } catch {
                print("Can't save isFavorite")
            }
        }
        
    }
}
