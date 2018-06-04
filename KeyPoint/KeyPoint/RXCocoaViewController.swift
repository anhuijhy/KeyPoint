//
//  RXCocoaViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/5.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RXCocoaViewController: UIViewController {

    let bag = DisposeBag()
    @IBOutlet weak var bindL: UILabel!
    @IBOutlet weak var tf: UITextField!
    
    @IBOutlet weak var twoTF: UITextField!
    @IBOutlet weak var threeTF: UITextField!
    
    @IBOutlet weak var actionBtn: UIButton!
    
    var subscription:Disposable?
    override func viewDidLoad() {
        super.viewDidLoad()

        _ =   tf.rx.text.asObservable().subscribe(onNext: { (s) in
            print("the txt is \(s ?? "mm")__")
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: bag)
        
        tf.rx.text.bind(to: bindL.rx.text).disposed(by: bag)
        
        
        //===============begin===============

        _ = Observable.combineLatest(tf.rx.text,twoTF.rx.text,threeTF.rx.text).map({ (s1,s2,s3) -> Bool in
            
            return (s1?.count)! > 6 && (s2?.count)! > 8 && (s3?.count)! > 10
            
        }).bind(to: actionBtn.rx.isEnabled).disposed(by: bag)
        
        
        //================end================
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


/// 扩展
extension UITextField {
    var ex_validState:AnyObserver<Bool>{
        return Binder(self) { textfield, valid in
            textfield.backgroundColor = valid ? UIColor.clear : UIColor.gray
            textfield.textColor = valid ? UIColor.gray : UIColor.white
            }.asObserver()
    }
}


extension UIButton {
    var ex_validState:AnyObserver<Bool>{
        return Binder(self) { button, valid in
            button.isEnabled = valid
            button.backgroundColor = valid ? UIColor.red : UIColor.blue
            }.asObserver()
    }
}
