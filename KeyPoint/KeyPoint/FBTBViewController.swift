//
//  FBTBViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/12.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import MJRefresh
class FBTBViewController: UIViewController ,ASTableDataSource,ASTableDelegate{

    let tableView = ASTableNode(style: .plain)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.view.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
//            self.tableView.view.mj_header.endRefreshing()
            self.request()
            
        })
        tableView.view.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
//            self.tableView.view.mj_header.endRefreshing()
            self.request()
        })
        self.view.addSubnode(tableView)
    }

    
    func request() -> Void {
        
        print("请求数据")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //==========================
//    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
//        print("就会有机会就会")
//        return true
//    }
//
//    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
//
//        context.beginBatchFetching()
//        self.request()
//    }

    func numberOfSections(in tableNode: ASTableNode) -> Int {
        
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        
        let c = CusCellNode.init()
        c.configureData(URL.init(string: "http://f.hiphotos.baidu.com/image/pic/item/03087bf40ad162d9175e639f1ddfa9ec8b13cd85.jpg")!, withTitle: "mmmmm")
        return c
    }
    
}
