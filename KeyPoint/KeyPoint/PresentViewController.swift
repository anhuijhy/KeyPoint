//
//  PresentViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/6.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift

class PresentViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    
    var newRepo = PublishSubject<String>()
    
    @IBAction func doneClick(_ sender: Any) {
        
        newRepo.onNext(input.text ?? "jason")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
