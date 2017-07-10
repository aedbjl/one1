//
//  vc3.swift
//  one
//
//  Created by iii-user on 2017/7/7.
//  Copyright © 2017年 iii-user. All rights reserved.
//

import UIKit

class vc3: UIViewController {

    let app = UIApplication.shared.delegate as! AppDelegate
    
    let fmgr = FileManager.default
    let docDir = NSHomeDirectory() + "/Documents"
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func test1(_ sender: Any) {
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRZAAAAM0rHfefCAA2DwjVJMYT-wLaCyGsrxkIIMwXOcuJAbXt4c1knsfh5Ngw6GuogMy5RNjr36AVaCn-zLptChG-gqh0fvZrQ-28X14q_Oa-w6_KkvJMvDDgzseDBl6eSUD8qEhBGvD8Fe79U9mKV-GXCxGIpGhQdqrKAuKkFx2TqTEmLTNLGFU9iuw&key=AIzaSyCVMCjEmHGDJW_FCrowCSyURwpSJt-M-Po")
        let req = URLRequest(url:url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req, completionHandler: {(data,resp,error)in
            if error == nil {
                print("download Ok")
                self.saveFile(data: data!)
                self.showImage(data: data!)
            }else{
                print("download fail")
            }
            
            
        })
        task.resume()
        
        
        
    
        
    }
    
    
    
    private func saveFile(data:Data){
        let imgFile = docDir + "/apple.jpg"
        let url = URL(fileURLWithPath: imgFile)
        do{
            try data.write(to: url)
            print("save ok")
        }catch{
            print(error)
        }
    }
    private func showImage(data: Data){
        //1.
        //        let img = UIImage(data: data)
        //        DispatchQueue.main.async {
        //            self.imageView.image = img
        //        }
        //2.
        let imgFile = docDir + "/apple.jpg"
        if fmgr.fileExists(atPath: imgFile){
            let img = UIImage(contentsOfFile: imgFile)
            
            DispatchQueue.main.async {
                self.imgView.image = img
            }
        }
        
    }
    
    
        
        
        
        
        
        
        
        

    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(docDir)
        
//        print(app.htmlCont!)
        
        // Do any additional setup after loading the view.
    }

   
}


