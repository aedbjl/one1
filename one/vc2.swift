import UIKit
import GooglePlacePicker

class vc2: UIViewController, CLLocationManagerDelegate {
    
    let lmgr = CLLocationManager()
    let app = UIApplication.shared.delegate as! AppDelegate
    var counter = 0
    let fmgr = FileManager.default
    let docDir = NSHomeDirectory() + "/Documents"
    private var photoDir:String?

    
    @IBAction func showHtml(_ sender: Any) {
        
        let vc3 = storyboard?.instantiateViewController(withIdentifier: "V4")
        show( vc3!, sender: self)
        
    }
    
    private func initStat() {
        
        self.photoDir = self.docDir + "/placePhoto"
        
        if !self.fmgr.fileExists(atPath: self.photoDir!) {
            do {
                try self.fmgr.createDirectory(atPath: self.photoDir!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStat()

        lmgr.requestAlwaysAuthorization()
        lmgr.delegate = self
        lmgr.startUpdatingLocation()
    }
    // Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    // Add a UIButton in Interface Builder, and connect the action to this function.
    @IBAction func pickPlace(_ sender: UIButton) {
        let dir2 = docDir + "/placePhoto"
        do{
            if fmgr.fileExists(atPath: dir2){
                try fmgr.removeItem(atPath: dir2)
            }
            
        } catch {
            print(error)
        }
        
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
            
            let url_base_str = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?rankby=distance&type=restaurant&"
            let url = URL( string: url_base_str + "key=\(self.app.gmsServicesKey)" + "&" + "location=\(place!.coordinate.latitude),\(place!.coordinate.longitude)" )
            
            //            let url_base_str = "https://maps.googleapis.com/maps/api/place/details/json?"
            //
            //            let url = URL( string: url_base_str + "key=\(self.app.gmsServicesKey)" + "&" + "placeid=\(place?.placeID as! String)" )
            //
            //            do {
            //                self.app.htmlCont = try String(contentsOf: url!)
            ////                print(self.app.htmlCont)
            //            } catch {
            //                print(error)
            //            }
            //
            if let data = try? Data(contentsOf: url!){
                if var jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                    
//                    jsonObj = jsonObj as! Array<[String:AnyObject]>
                    
                    //print((jsonObj as AnyObject).description)
                    //print(type(of: jsonObj as AnyObject))
                    for (key, val) in jsonObj as! [String:AnyObject]{
                        if key == "results" {

                            for k in val as! [AnyObject] {
//                                print("name:\(k["name"] as! String)")
//                                print("place_id:\(k["place_id"] as! String)")

                    
                                let arr = k["photos"] as? Array<Dictionary<String,Any>>
                                
//                                print((arr?[0]["photo_reference"]) as? String as Any)
                                
//                                self.app.jsonResults += [[:]]
                                self.app.jsonResults.append(["name":k["name"] as! String])
//                                self.app.jsonResults[self.counter]["name"] = (k["name"] as! String)
                                self.app.jsonResults[self.counter]["place_id"] =
                                    (k["place_id"] as! String)
                                self.app.jsonResults[self.counter]["photo_reference"] = (arr?[0]["photo_reference"] as? String ?? "")
                                self.counter += 1
//                                self.app.jsonResults += ["name:\(k["name"] as! String),place_id:\(k["place_id"] as! String),photo_reference:\(arr?[0]["photo_reference"] as? String ?? "")"]
                                
                            }
 
                        }
    
                    }
                    
                }
   
            }
        })
    }
    
    
    @IBAction func updata(_ sender: Any) {
        pic()
    }
    
    
    
    private func wgetPhoto(_ url_string: String, toPath: String ) throws {
        let url = URL(string: url_string)
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req, completionHandler: {(data, resp, error) in
            
            if error == nil {
                print("wgetPhoto() OK")
                
                DispatchQueue.global().async {
                    self.saveFile(data: data!, destination: toPath )
                }
                
            } else {
                print("wgetPhoto() fails")
            }
        })
        
        task.resume()
    }
    
    private func saveFile(data: Data, destination: String) {
        let url = URL(fileURLWithPath: destination )
        do {
            try data.write(to: url )
        } catch {
            print(error)
        }
    }
    
    
    
    private func pic() {
        DispatchQueue.main.async {
            
            self.initStat()
            do {
                for i in self.app.jsonResults {
                    
                    let photoURL_str = String("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(i["place_reference"] as! String)&key=\(self.app.gmsServicesKey)")
                    
                    let photoPath_str = self.photoDir! + "/" + (i["place_id"] as! String) + ".jpg"
                    
                    if !self.fmgr.fileExists(atPath: photoPath_str) {
                        try self.wgetPhoto(photoURL_str!, toPath: photoPath_str)
                        
                        
                    }
                }
                
                
            } catch {
                print(error)
            }
        }
    }
    
   

    
    
    
}
