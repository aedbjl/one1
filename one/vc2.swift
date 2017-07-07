import UIKit
import GooglePlacePicker

class vc2: UIViewController, CLLocationManagerDelegate {
    
    let lmgr = CLLocationManager()
    let app = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func showHtml(_ sender: Any) {
        
        let vc3 = storyboard?.instantiateViewController(withIdentifier: "vc3")
        show( vc3!, sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lmgr.requestAlwaysAuthorization()
        lmgr.delegate = self
        lmgr.startUpdatingLocation() 
        }
    // Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    // Add a UIButton in Interface Builder, and connect the action to this function.
    @IBAction func pickPlace(_ sender: UIButton) {
        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                self.nameLabel.text = place.name
                self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                    .joined(separator: "\n")
                print("Place attributions \(place.placeID)")
            } else {
                self.nameLabel.text = "No place selected"
                self.addressLabel.text = ""
            }
            
            let url_base_str = "https://maps.googleapis.com/maps/api/place/details/json?"
            
            let url = URL( string: url_base_str + "key=\(self.app.gmsServicesKey)" + "&" + "placeid=\(place?.placeID as! String)" )
            
            do {
                self.app.htmlCont = try String(contentsOf: url!)
//                print(self.app.htmlCont)
            } catch {
                print(error)
            }
            
            
            
            
            
            
            
            
            
          
        })
    }
}
    
