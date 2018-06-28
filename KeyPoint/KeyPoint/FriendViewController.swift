//
//  FriendViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/14.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    lazy var commentTV: UITableView = {
    
        let tab = UITableView.init(frame: self.view.bounds, style: .plain)
        tab.backgroundColor = UIColor.white
        tab.delegate = self
        tab.dataSource = self
        self.view.addSubview(tab)
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        _ = self.commentTV
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


extension FriendViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCell(withIdentifier: "commentcell") as? CommentCell
        if cell == nil {
            
            cell = CommentCell.init(style: .default, reuseIdentifier: "commentcell")
        }
        cell?.setDataSource()
        return cell!
    }

}
