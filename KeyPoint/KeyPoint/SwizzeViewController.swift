//
//  SwizzeViewController.swift
//  KeyPoint
//
//  Created by 123 on 2018/3/30.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class SwizzeViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.changeMethod()
//        self.originalMethod()
        self.swizzeMethod()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeMethod(){
        
        let originaMethod = class_getInstanceMethod(object_getClass(self), #selector(self.originalMethod))
        let swizzeMethod = class_getInstanceMethod(object_getClass(self), #selector(self.swizzeMethod))
        
        method_exchangeImplementations(originaMethod!, swizzeMethod!)
    }
    

    @objc dynamic func originalMethod(){
        
        print("我是原始方法")
    }
    
    @objc dynamic func swizzeMethod(){
        
        print("我是交换方法")
        self.swizzeMethod()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    deinit {
        print("deinit")
    }
}


