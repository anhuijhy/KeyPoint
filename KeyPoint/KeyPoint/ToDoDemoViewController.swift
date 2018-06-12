//
//  ToDoDemoViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/28.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
class ToDoDemoViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var DelBtn: UIButton!
    
    @IBOutlet weak var AddItemBtn: UIButton!
    
    let todoItems = Variable<[ToDoModel]>([])
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        todoItems.asObservable().subscribe(onNext: {[weak self] (m) in
            //订阅到事件
            print("订阅到的value\(m)")
        self?.updateUI(m)
            
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: bag)
        
    }

    func updateUI(_ s:[ToDoModel]){
        
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddItemAction(_ sender: Any) {
        
        let todoItem = ToDoModel.init()
        self.todoItems.value.append(todoItem)
    }
    
    @IBAction func removeallAction(_ sender: Any) {
        
        let m: ToDoModel =   self.todoItems.value[0]
        m.titleStr = "ddd"
        self.todoItems.value[0] = m
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
