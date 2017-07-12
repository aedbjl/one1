//
//  V1ViewController.swift
//  one
//
//  Created by iii-user on 2017/7/11.
//  Copyright © 2017年 iii-user. All rights reserved.
//

import UIKit

class V1ViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource{
    
    let app = UIApplication.shared.delegate as! AppDelegate
    var counter = 0
    let fmgr = FileManager.default
    let docDir = NSHomeDirectory() + "/Documents"
    private var photoDir:String?
//    var  mydata:Array<String> = []


    
    
    @IBAction func next(_ sender: Any) {
        if let v4 = storyboard?.instantiateViewController(withIdentifier: "random"){
            show(v4, sender : self)
        }
        
        
        
    }
    @IBOutlet weak var tableView: UITableView!
    
    
//    private let myData = [""]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.jsonResults.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resCell") as! CustomTableViewCell

        let photoPath_str = photoDir! + "/" + ( app.jsonResults[indexPath.row]["place_id"] as! String ) + ".jpeg"
        if fmgr.fileExists(atPath: photoPath_str) {
            DispatchQueue.main.async {
                cell.imgView.image = UIImage(contentsOfFile: photoPath_str)
                
                
            }
            
            
        } else {
            
//            cell.img.image = UIImage(named: "none.png")
            
        }
        
        
        
        cell.label.text = self.app.jsonResults[indexPath.row]["name"] as! String
 
        
//        self.app.mydata += [self.app.jsonResults[indexPath.row]["name"]!]
        
        
        
        return cell
        
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
            
                       
            do {
                
                
                  for i in 0..<self.app.jsonResults.count {
                    var placeRef = self.app.jsonResults[i]["photo_reference"] ?? ""
                    let photoURL_str = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(placeRef)&key=\(self.app.gmsServicesKey)"
                    
                    let photoPath_str = self.photoDir! + "/" + (self.app.jsonResults[i]["place_id"] as! String) + ".jpeg"
                    
                    
                    
                    
                    if !self.fmgr.fileExists(atPath: photoPath_str) {
                        try self.wgetPhoto(photoURL_str, toPath: photoPath_str)
                        
//                        var img = UIImage(named: "")
//                        [UIImage,UIImage]
//                        var myimage = [img]
                        
//                        var img = UIImage(contentsOfFile: photoPath_str)
//                        self.app.myimage += [img!]
                        
//                        myimage += [UIImage(contentsOfFile: photoPath_str)]
                    
                    }
                    
//                    let placeID:String = i["place_id"]! as! String
                    let img = UIImage(contentsOfFile: photoPath_str)
                    self.app.jsonResults[i]["img"] = img
//                    print(placeID)
//                    print(img?.description)
//                    self.app.myImgDict[placeID] = img
                    
                    
                    
                    
                    
                }
                
                print(self.app.myImgDict.description)

                
            } catch {
                print(error)
            }
            
            
           

            
            
        }
    
    }
    
    private func initStat() {
        
        self.photoDir = self.docDir + "/placePhoto"
        
        if !self.fmgr.fileExists(atPath: self.photoDir!) {
            do {
                try self.fmgr.createDirectory(atPath: self.photoDir!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }else {
            
            
            
        }
    }

    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStat()
//        for i in 0...app.jsonResults.count{
//            pic()
//        }
        pic()
        print(docDir)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




//            https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU&key=YOUR_API_KEY
