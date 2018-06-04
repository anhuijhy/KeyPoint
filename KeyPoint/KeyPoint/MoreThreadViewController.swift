//
//  MoreThreadViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/14.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class MoreThreadViewController: UIViewController {
    
    @IBOutlet weak var ImgV: UIImageView!
    let opq = OperationQueue.init()
    var timer:DispatchSourceTimer!
    
    let imgUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523734265705&di=3724c6946df53d591a73132d60151726&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140411%2F3970232_115400821000_2.jpg"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //循环
    @IBAction func apply_round(_ sender: Any) {
        
        let q = DispatchQueue.global()
        q.sync {
            
            print("begnn to start a dispatchapply")
            
            DispatchQueue.concurrentPerform(iterations: 10) { (idx) in
                
                print("iteration times:\(idx),Thread = \(Thread.current)")
            }
            
            print("iteration has complate")
        }
        
    }
    
    
    //cgd 计时器
    @IBAction func sourceTimer(_ sender: Any) {
        let workItem = DispatchWorkItem.init {
            print("gcd timer gcd timer")
        }
        timer = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        timer.schedule(deadline: .now() , repeating: 1, leeway: .milliseconds(10))
        timer.setEventHandler(handler: workItem)
        timer.resume()
    }
    
    @IBAction func after(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            print("after 3s")
        }
        
    }
    
    
    @IBAction func group_Notify(_ sender: Any) {
        
        let group = DispatchGroup()
        
        let queueBook = DispatchQueue(label: "book")
        print("start networkTask task 1")
        queueBook.async(group: group) {
            sleep(2)
            print("End networkTask task 1")
        }
        let queueVideo = DispatchQueue(label: "video")
        print("start networkTask task 2")
        queueVideo.async(group: group) {
            sleep(10)
            print("End networkTask task 2")
        }
        
        
        group.notify(queue: DispatchQueue.main) {
            print("all task done")
        }
        
        
    }
    
    
    @IBAction func GCDAction(_ sender: Any) {
        weak var weakself = self
        //normal
                let q = DispatchQueue.init(label: "com.jason.jason")
                q.sync {
                    print("同步线程")
                    weakself?.downImg(imgUrl)
                }
//                q.async {
//                    print("异步线程")
//                    weakself?.downImg(weakself!.imgUrl)
//                 }
        
//        self.gcdQos()
    }
    
    //qos
    func gcdQos(){
        //串行
        //        let q = DispatchQueue.global(qos: .default)
        let q = DispatchQueue.init(label: "com.demo.jason", qos: .default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
        q.sync {

            self.downImg(self.imgUrl)
        }
    }
    
    
    @IBAction func NSOperationAction(_ sender: Any) {
        let invocationOP = BlockOperation.init {
                        print("======the thread is \(Thread.current)")
            self.downImg("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523734265705&di=3724c6946df53d591a73132d60151726&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140411%2F3970232_115400821000_2.jpg")
        }
        
        opq.addOperation(invocationOP)
    }
    
    @IBAction func nsThread(_ sender: Any) {
        
        //        self.nsthreadone()
        self.nsthreadtwo()
        
    }
    
    func nsthreadone(){
        
        let thread = Thread.init(target: self, selector: #selector(downImg(_:)), object: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523734265705&di=3724c6946df53d591a73132d60151726&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140411%2F3970232_115400821000_2.jpg")
        thread.start()
        
    }
    
    func nsthreadtwo(){
        
        Thread.detachNewThreadSelector(#selector(downImg(_:)), toTarget: self, with: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523734265705&di=3724c6946df53d591a73132d60151726&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140411%2F3970232_115400821000_2.jpg")
    }
    
    func nsthreadthree(){
        
        
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

extension MoreThreadViewController{
    @objc func downImg(_ a:String){
        print("======the thread name is \(Thread.current)")
        let imgData = try? Data.init(contentsOf: URL.init(string: a)!)
        guard let _ = imgData else {
            return
        }
        let img = UIImage.init(data: imgData!)
        self.performSelector(onMainThread: #selector(refreshImgV(_:)), with: img, waitUntilDone: true)
        
    }
    
    @objc func refreshImgV(_ img:UIImage){
        
        self.ImgV.image = img
    }
}
