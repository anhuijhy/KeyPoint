//
//  RXAlamofireViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/5.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import Alamofire

class RXAlamofireViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let house = House.B.rawValue
        print("the house is \(house)")
        
//        Alamofire.request(ToDoRouter.post(["jhy" : "jhyjhy"]))
        Alamofire.request(ToDoRouter.get(nil))
        .responseJSON { (response) in
            
            guard response.result.error == nil else{
                print("response.result.error!")
                return
            }
            
            guard let todos = response.result.value as? [[String:Any]] else{
                print("cannot read the to do list")
                return
            }
            
            todos.reversed().forEach({ (dic) in
                print("the item dic is \(dic)")
            })
            
        }
        
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
