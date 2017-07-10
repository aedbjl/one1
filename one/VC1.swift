//
//  VC1.swift
//  one
//
//  Created by iii-user on 2017/7/6.
//  Copyright © 2017年 iii-user. All rights reserved.
//

import UIKit
import GooglePlaces


class VC1: UIViewController, CLLocationManagerDelegate {

    var placesClient: GMSPlacesClient!
    
    // Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let lmgr = CLLocationManager()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        lmgr.requestAlwaysAuthorization()
        lmgr.delegate = self
        lmgr.startUpdatingLocation()
        
        
        placesClient = GMSPlacesClient.shared()
    }
    
    // Add a UIButton in Interface Builder, and connect the action to this function.
    @IBAction func getCurrentPlace(_ sender: UIButton) {
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                }
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    let place = likelihood.place
                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
                    print("Current Place address \(place.formattedAddress)")
                    print("Current Place attributions \(place.attributions)")
                    print("Current PlaceID \(place.placeID)")
                }
            }
            
            
        })
    }
}
