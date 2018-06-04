//
//  RXFlatMaoViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/4.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
class RXFlatMaoViewController: UIViewController {
   let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let john = Player(score: Variable(70))
        let jole = Player(score: Variable(90))
        
        let players = PublishSubject<Player>()

        players.asObservable()
            .flatMap { p in
                p.score.asObservable()
            }.subscribe(onNext: { (s) in
                print("the score is\(s)")
            }, onError: { (err) in
                
            }, onCompleted: {
                
            }) {
                print("disposed")
        }.disposed(by: bag)

       players.onNext(john)
        players.onNext(jole)
        john.score.value = 100
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
