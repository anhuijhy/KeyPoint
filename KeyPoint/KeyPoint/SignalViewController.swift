//
//  SignalViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/24.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class SignalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func singal(_ sender: Any) {
        
        let  semaphore = DispatchSemaphore.init(value: 0)
        

               //网络请求等延时操作
        //这里只能输出信号量释放before wait ，因为+3后 是在3s后执行代码，所以信号永不会被释放
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                print("信号量释放")
                semaphore.signal()
            }
            print("信号量释放before wait")
        
        _ =  semaphore.wait(timeout: DispatchTime.distantFuture)
            print("信号量释放完毕")

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
