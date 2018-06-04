//
//  ZipViewController.swift
//  KeyPoint
//
//  Created by 123 on 2018/4/3.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class ZipViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        let zip1 = [1,2,3,9,90]
        let zip2 = [4,5,6,7]
        let zipSum = zip(zip1, zip2)
        dump(zipSum)
        for (i1,i2) in zipSum{
            print("zip1:\(i1),zip2:\(i2)")
        }
        
     let a = [10,20,32,50,60]
      print("mmm\(a[1,2,4])")
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


extension Array{
    
    subscript (i1:Int ,i2:Int,rest:Int ...) -> [Element]{
        
        get {
            
            var result:[Element] = [self[i1],self[i2]]
            
            for index in rest{
                
                result.append(self[index])
            }
            
            return result
            
        }set(values){
         
            for (index,value) in zip([i1,i2] + rest,values) {
                self[index] = value
            }
        }
    }
    
}
