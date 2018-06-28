//
//  RXViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/8.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift

enum CustomeError:Error {
    case somethingError
}

class RXViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //observable 时间控制
    @IBAction func TimerAction(_ sender: Any) {
    
//        let tobservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe(onNext: { (event) in
//            print("the interval is \(event)")
//        }, onError: { (e) in
//            print("error")
//        }, onCompleted: {
//            print("completed")
//        }) {
//
//            print("回收")
//        }
//
//
//        delay(5) {
//
//         tobservable.dispose()
//        }

        
         var bag = DisposeBag()
        
         Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe(onNext: { (k) in
            print("the time is \(k)")
        }, onError: { (e) in
            
        },  onCompleted: {
            
        }) {
            
        print("回收")
        }.disposed(by: bag)
        
        delay(5) {
            
            bag = DisposeBag()
        }

}

    //一般observable map
    @IBAction func OBActionOne(_ sender: Any) {
        
        var arr =  Observable.of("1","2","3","4","5","6","7","8","9","b").map { (s) -> Int? in
            return Int(s)
            }.filter { (i) -> Bool in
                
                if let _ = i,  i! % 2 == 0 {
                    return true
                }else{
                    return false
                }
        }
        
        arr.skip(2).subscribe { (event) in
            
            print("event\(event)")
        }

     let resutlt =  arr.skip(2).subscribe(onNext: { (w) in
            print("dd\(w ?? 99)")
        }, onError: { (err) in
            
                print("错误是\(err)")
        }, onCompleted: {
                  print("complate")
        }, onDisposed: {
            
        })
        print("the map and fliter result is \(resutlt)")
    }
    
    // create observable
    @IBAction func createOB(_ sender: Any) {
        
        let customOB = Observable<Int>.create { ob in
            
            ob.onNext(10)
            ob.onNext(11)
            ob.onError(CustomeError.somethingError)
            ob.onCompleted(
            )
             return Disposables.create()
        }
        
        let dispiseBag  = DisposeBag()
        customOB.debug().subscribe(onNext: { (i) in
            print("打印数据\(i)")
        }, onError: { (e) in
            print("error\(e)")
        }, onCompleted: {
             print("game Completed")
        }) {
            print("game over")
        }.disposed(by: dispiseBag)
        
    }
    //四中subject
    // 要先注册subscribe 然后onNext才能订阅到事件
    @IBAction func PublishObject(_ sender: Any) {
        
        let subject = PublishSubject<String>()
        //自己也可以作为订阅者
//        subject.asObserver().subscribe { (event) in
//
//            print("sub1 -what happened:\(event)")
//        }
//
//        subject.onNext(
//        "ddddd")
        let sub1 = subject.subscribe { (event) in
            
            print("sub1 -what happened:\(event)")
        }
        
        subject.onNext("ep1 update")
        sub1.dispose()
        
    }
    
    //1.第一个订阅者有默认事件以及后面的事件（）
    //2.对于后来的订阅者会预定到后面的事件以及之前最近的一次事件
    //3.其实第一个订阅者的默认感觉就类似后面的订阅者订阅到的最近一次事件
    @IBAction func behaviorObject(_ sender: Any) {
    
        let subject = BehaviorSubject<String>(value: "rxswift step by step")
        let sub1 = subject.subscribe { (event) in
            
            print("sub1 - what happened:\(event)")
            print("mmmmm\(event.element ?? "")")
        }
        
        subject.onNext("我是订阅事件1")
        sub1.dispose()
    }
    
    //指定预定之前几个事件，没有默认值
    @IBAction func replaySubject(_ sender: Any) {
    
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        let sub1 = subject.subscribe { (event) in
            
            print("sub1 - what happened:\(event)")
            print("mmmmm\(event.element ?? "")")
        }
        
        subject.onNext("我是订阅事件1")
        subject.onNext("我是订阅事件2")
        subject.onNext("我是订阅事件3")
        sub1.dispose()
        
        let sub2 = subject.subscribe { (event) in
            
            print("sub2 - what happened:\(event)")

        }
        
        sub2.dispose()
    }
    
    @IBAction func Varibale(_ sender: Any) {
    
        let stringVariable = Variable("episonde1")
        stringVariable.value = "ddd"
        print("the str value is \(stringVariable.value)")
        
    }
    
    /// 执行delay 事件
    ///
    /// - Parameters:
    ///   - delay: <#delay description#>
    ///   - closure: <#closure description#>
    func delay(_ delay:Double,closure :@escaping () -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
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
