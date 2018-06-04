//
//  ToDemoHelperViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/28.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
extension ToDoDemoViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cid:String = "cid"
        var cell = tableView.dequeueReusableCell(withIdentifier: cid) as? ToDoCell
        if cell == nil {
            
            cell = ToDoCell.init(style: .default, reuseIdentifier: cid)
        }
        cell?.configCell(self.todoItems.value[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
             return    self.todoItems.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
extension ToDoDemoViewController:UITableViewDelegate{
    
    
    
}
