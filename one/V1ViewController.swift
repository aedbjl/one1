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
    @IBOutlet weak var tableView: UITableView!
    
    
    private let myData = [""]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "V4") as! CustomTableViewCell
        cell.textLabel?.text = myData[indexPath.row]
        return cell
    }

    

    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(app.jsonResults[0])
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
