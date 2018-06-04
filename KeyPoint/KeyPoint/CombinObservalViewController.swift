//
//  CombinObservalViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/5.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
class CombinObservalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let textFeild = BehaviorSubject<String>(value: "jhy")
        let submitBtn = PublishSubject<Void>()
        let bag = DisposeBag()
        
        submitBtn.withLatestFrom(textFeild)
            .subscribe(onNext: { (str) in
                
                print("the feild txt is\(str)")
                
            }, onError: { (err) in
                
            }, onCompleted: {
                
            }) {
                
        }.disposed(by: bag)
        
        submitBtn.onNext(())
        textFeild.onNext("the new str")
        submitBtn.onNext(())
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
