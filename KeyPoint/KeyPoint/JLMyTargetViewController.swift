//
//  JLMyTargetViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/7/9.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import JLRoutes
class JLMyTargetViewController: UIViewController ,JLRRouteHandlerTarget{
    
    var parameters = Dictionary<String, Any>()
//    var p:Dictionary<String, Any>?
    
    required init(routeParameters parameters: [String : Any]) {
        super.init(nibName: nil, bundle: nil)
        
        print("the rountes parametes is \(parameters)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "JLRountes Push Test"
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
