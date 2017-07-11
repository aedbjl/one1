//
//  ViewController.swift
//  one
//
//  Created by iii-user on 2017/7/6.
//  Copyright © 2017年 iii-user. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func backHere(segue : UIStoryboardSegue){
        print("back home")
    }

    
    private let myData = ["1","2","3","4"]
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = myData[indexPath.row]
        return cell!
    }
    
    
    @IBAction func gotovc1(_ sender: Any) {
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoVC(whereVC: indexPath.row)
    }
    private func gotoVC(whereVC:Int){
        switch (whereVC){
        case 3 :
            if let v4 = storyboard?.instantiateViewController(withIdentifier: "V5"){
                show(v4, sender : self)
            }
            
            break
        case 2 :
            if let vc1 = storyboard?.instantiateViewController(withIdentifier: "vc1"){
                show(vc1, sender : self)
            }
            
            break
        case 1 :
            if let vc2 = storyboard?.instantiateViewController(withIdentifier: "vc2"){
                show(vc2, sender: self)
            }
        case 0 :
            if let vc3 = storyboard?.instantiateViewController(withIdentifier: "vc3"){
                show(vc3, sender: self)
            }
        default:
            break
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   


}

