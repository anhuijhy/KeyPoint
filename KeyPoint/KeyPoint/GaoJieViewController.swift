//
//  GaoJieViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/8.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class GaoJieViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func compactMapAction(_ sender: Any) {
        
        let stringa = ["1","2","3","4","5","6","7","8","9","0"]
        
        let  a =    stringa.compactMap { (s) -> Int? in
            
            return Int(s)
            
            }.filter { (ii) -> Bool in
                
                return ii % 2 == 0
        }
        
        print("mmm\(a)")
    }
    
    
    @IBAction func compactAction2(_ sender: Any) {
        
        let arr = ["Apple","Orange","puple",""]
        let arr1 = arr.compactMap { (a) -> Int? in
            let length = a.count
            //            guard length > 0 else {return nil }
            return length
        }
        
        print("对数组中的每个字符串做长度\(arr1)")
    }
    
    @IBAction func dTod(_ sender: Any) {
        
        let array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        
        
        let arr2 = array.compactMap{ $0 }
        
        print("将一个二维数组合成一个一维数组\(arr2)")
    }
    
    @IBAction func combinArr(_ sender: Any) {
        
        let arr = ["Apple","Orange","puple",""]
        let arr1 = ["3","5","7"]
        let combine  =  arr.compactMap { f in
            
            arr1.compactMap({ c in
                
                return f+c
            })
        }
        
        print("合并数组\(combine)")
    }
    
    
    
    @IBAction func FilerAction(_ sender: Any) {
        
        let arr = ["objectttttttt-c","swift","html","csssssssssssssss","ruby","c++"]
        let filterArr =   arr.filter(sringCountLessThan10)
        print("使用方法过滤\(filterArr)")
        
        let filterArr2 = arr.filter { (s) -> Bool in
            return s.count < 10
        }
        
        print("block方法过滤\(filterArr2)")
    }
    
//    用方法的方式实现
    func sringCountLessThan10(string: String) ->Bool{
        
        return string.count < 10
        
    }
    
    
    @IBAction func reduceAction(_ sender: Any) {
        
        let stringArray = ["Objective-C", "Swift", "HTML", "CSS", "JavaScript"]
        let reduceArr =   stringArray.reduce("v") { (str1, str2) -> String in
            
            return str1 == ""  ?  str2 : str1 + "_" + str2
        }
        
        print("reduce arr is \(reduceArr)")
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
