//
//  test.swift
//  one
//
//  Created by iii-user on 2017/7/11.
//  Copyright © 2017年 iii-user. All rights reserved.
//

import UIKit

class test: UIViewController {
    let app = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in app.jsonResults {
        print(i["name"]!)
        print(i["place_id"]!)
        print(i["photo_reference"]!)
            
        }
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
