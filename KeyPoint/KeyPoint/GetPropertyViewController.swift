//
//  GetPropertyViewController.swift
//  KeyPoint
//
//  Created by 123 on 2018/3/29.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

extension Array {
    subscript (safe index: Int) -> Element? {
    return (0..<count).contains(index) ? self[index] : nil
    }
}

class GetPropertyViewController: UIViewController {

    @objc dynamic  var p1 = "p1"
    @objc dynamic var p2 = "p2"
    var p3 = "p3"
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
        
        let a :Array = ["one","two","three"];
        print("swift 数组越界取值\(a[safe:20] ?? "nilmmm")")
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
