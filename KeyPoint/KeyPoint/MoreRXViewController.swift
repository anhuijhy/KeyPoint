//
//  MoreRXViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/6.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MoreRXViewController: UIViewController {

    @IBOutlet weak var inputTF: UITextField!
    
    @IBOutlet weak var actionBtn: UIButton!
    
    @IBOutlet weak var tipL: UILabel!
    
    
    lazy var b: UIButton = {
        let v = UIButton(type: .custom)
        v.backgroundColor = UIColor.red
        v.frame = CGRect.init(x: 0, y: 100, width: 60, height: 60)
        self.view.addSubview(v)
        return v
    }()
    
    //======
    lazy var itemb: UIBarButtonItem = {
        
        let ib = UIBarButtonItem.init()
        ib.customView = self.b
        self.navigationItem.rightBarButtonItem = ib
        return ib
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //绑定字符长度
     
        _ = inputTF.rx.text.map{ str in
            (str?.count)! > 6
            }.bind(to: actionBtn.rx.isEnabled)
        
        //可带修改drive
        _ = (inputTF.rx.text).orEmpty.asDriver()
            .map({ s in
                
                "jhy\(s)"
                
            }).drive(tipL.rx.text)
        
         //===
         //===tap 事件map
         _  = actionBtn.rx.tap
            .flatMap{[weak self] (_) -> Observable<String> in

                let vc = PresentViewController.init(nibName: "PresentViewController", bundle: nil)
                self?.present(vc, animated: true, completion: nil)
                
                return vc.newRepo.asObservable()
                
            }.subscribe(onNext: { (s) in
                self.inputTF.text = s
                self.dismiss(animated: true, completion: nil)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        //===========

        self.someNormalMethod()
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

extension MoreRXViewController{
    
    func someNormalMethod() ->Void{
    
      _ =  self.myJust(element: 0).subscribe(onNext: { (n) in
            
            print("the number is \(n)")
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    ////////////////////
}

extension MoreRXViewController{
    
    func myJust<E>(element:E) -> Observable<E>{
        
        return Observable.create({ (observer) -> Disposable in
            
            observer.on(.next(element))
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
