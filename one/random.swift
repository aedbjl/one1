//
//  random.swift
//  one
//
//  Created by iii-user on 2017/7/12.
//  Copyright © 2017年 iii-user. All rights reserved.
//

import UIKit

class random: UIViewController {

    let app = UIApplication.shared.delegate as! AppDelegate
    var imgs:[UIImage] = []
    var str:[String] = []
    @IBAction func down(_ sender: Any) {
        
        for obj in app.jsonResults {
            imgs += [obj["img"] as? UIImage ?? UIImage()]
//            print(obj["img"])
            str += [obj["name"] as! String]
            
        }
        
        imgView.animationImages = imgs
        imgView.animationDuration = 0.2
        imgView.animationRepeatCount = 10000
        
        imgView.startAnimating()
    }
    
    @IBAction func up(_ sender: Any) {
        let rand = Int(arc4random_uniform(UInt32(self.imgs.count)))
        imgView.stopAnimating()
        imgView.image = imgs[rand]
//        text.text = self.app.jsonResults[rand]["name"] as! String
//        imgView.image = self.app.jsonResults[rand]["img"] as! UIImage
        
        text.text = str[rand]
        print(str[rand])
    }
    
    @IBAction func outside(_ sender: Any) {
        let rand = Int(arc4random_uniform(UInt32(self.imgs.count)))
        imgView.stopAnimating()
        imgView.image = imgs[rand]
        text.text = str[rand]
        
        
    }
    
    
    
    
    @IBOutlet weak var text: UILabel!
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(app.myImgDict)
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
