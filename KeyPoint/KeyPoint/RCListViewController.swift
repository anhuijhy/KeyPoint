//
//  RCListViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/5/31.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class RCListViewController: RCConversationListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setDisplayConversationTypes([1,2,3,4,5,6])
        
        //self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION,RCConversationType.ConversationType_GROUP])
        
        //        self.conversationListTableView.register(ConversationCell.self, forCellReuseIdentifier: "mancell")
        print("聊天列表\(self.conversationListDataSource)")
        ;
        
        //        self.refreshConversationTableViewIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        print("the list is \(self.conversationListDataSource)")
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

extension RCListViewController{
    
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        
        print("the select model is\(model) the list is\(self.conversationListDataSource.count)")
        
        let vc = RCChatViewController()
        vc.conversationType = .ConversationType_PRIVATE
        vc.targetId = model.targetId
        vc.navigationItem.title = model.conversationTitle
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //:-- 自定义Cell ，添加会话列表模型
    
    /*.................................http://support.rongcloud.cn/kb/MjUz
     
    override func rcConversationListTableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> RCConversationBaseCell! {
        
    }
    
    override func rcConversationListTableView(_ tableView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        
        return 80
    }
    
    override func willReloadTableData(_ dataSource: NSMutableArray!) -> NSMutableArray! {

    }
    
    override func didReceiveMessageNotification(_ notification: Notification!) {
        
        print("收到插入信息\(notification.userInfo)")
    }
  */
}


//.................................修改UI 布局
extension RCListViewController{
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.conversationListDataSource.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "mancell") as? ConversationCell

        if cell == nil {

            cell = ConversationCell.init(style: .default, reuseIdentifier: "mancell")
        }
        let m = self.conversationListDataSource[indexPath.row] as! RCConversationModel
        m.cellBackgroundColor = UIColor.red
        cell?.setDataModel(m)

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
}



