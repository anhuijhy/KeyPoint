//
//  GetPropertyBaseOCViewController.swift
//  KeyPoint
//
//  Created by 123 on 2018/3/30.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
class GetPropertyBaseOCViewController: OCViewController {

    @objc dynamic  let ocp1 = "ocp1"
    let ocp2 = "ocp2"
    var count :UInt32 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        let pa = class_copyPropertyList(object_getClass(self), &count)
        for i in 0 ..< numericCast(count){
            
            let pb = property_getName(pa![i])
            
            print("属性成员属性:%@",String.init(utf8String: pb) ?? "没有找到你要的属性");
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
