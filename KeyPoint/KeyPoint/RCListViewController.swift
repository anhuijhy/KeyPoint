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
        
   self.setDisplayConversationTypes([1,2,3,4,5,6,7,8,9])
        
//        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION,RCConversationType.ConversationType_GROUP])
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

extension RCListViewController{
    
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        
        print("the select model is\(model)")
        
        let vc = RCChatViewController()
        vc.conversationType = .ConversationType_PRIVATE
        vc.targetId = model.targetId
        vc.navigationItem.title = model.conversationTitle
        self.navigationController?.pushViewController(vc, animated: true)
 
    }
    
}


