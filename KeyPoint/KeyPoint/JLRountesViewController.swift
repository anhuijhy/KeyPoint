//
//  JLRountesViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/7/6.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import JLRoutes

class JLRountesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let r = JLRoutes.global()
        r.addRoute("/user/view/:userID", priority:0) { (dic) -> Bool in

            let userid = dic["userID"] as? String
            let JLRoutePattern = dic["JLRoutePattern"] as? String

            print("JLRounte Push\(userid ?? "") parameter\(JLRoutePattern ?? "")")
            print("parameters[JLRouteWildcardComponentsKey] = \(dic["JLRouteWildcardComponentsKey"] ?? "no wildcard")")
            let vc = JLTestViewController.init(nibName: "JLTestViewController", bundle: nil)
            vc.userID = userid
            self.navigationController?.pushViewController(vc, animated: true)
            return true
        }
        
        
//        r.addRoute("/wildcard/*", priority: 0) { (dic) -> Bool in
//
//            print("the dic is \(dic)")
//            print("parameters[JLRouteWildcardComponentsKey] = \(dic["JLRouteWildcardComponents"] ?? "no wildcard")")
//
//            return true
//        }
        
        let handlerBlock = JLRRouteHandler.handlerBlock(forTargetClass: JLMyTargetViewController.self) { (vc) -> Bool in
            
            self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
            return true
        }
        
        r.addRoute("/user/viewpush/:userID", priority: 0, handler: handlerBlock)
    }

    @IBAction func rountAction(_ sender: Any) {
        
        let url = URL.init(string: "myapp://user/view/123")
//        let url = URL.init(string: "myapp://wildcard/jhy")
        JLRoutes.routeURL(url)
    }
    
    
    @IBAction func jlrountesPush(_ sender: Any) {
        
        let url = URL.init(string: "myapp://user/viewpush/123")
        //        let url = URL.init(string: "myapp://wildcard/jhy")
        JLRoutes.routeURL(url)
        
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
