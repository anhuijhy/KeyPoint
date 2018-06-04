//
//  RXTvViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/6.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
class RXTvViewController: UIViewController {

    lazy var tv = { () -> UITableView in
       let tv = UITableView.init(frame: self.view.bounds, style: .plain)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cid")
        tv.delegate = self
        self.view.addSubview(tv)
        return tv
    }()
    
    let items = Observable.just([
        "First item",
        "Second item",
        "Third item"
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       _ = items.bind(to: self.tv.rx.items(cellIdentifier: "cid", cellType: UITableViewCell.self)){(row ,e,cell) in
            
              cell.textLabel?.text = "\(e)@row\(row)"
        }
        
     _ =   tv.rx.modelSelected(String.self).subscribe(onNext: { (str) in
            print("the model str is\(str)")
            
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }
    
        _ =  tv.rx.itemSelected.subscribe(onNext: { (str) in
            print("the model str is\(str)")
            
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
        }
        
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

extension RXTvViewController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
