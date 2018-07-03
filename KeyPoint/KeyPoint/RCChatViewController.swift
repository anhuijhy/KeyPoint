//
//  RCChatViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/5/31.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class RCChatViewController: RCConversationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册自定义消息
        
        RCIM.shared().registerMessageType(JhyMessage.self)
        self.register(JhyMessageCell.self, forMessageClass: JhyMessage.self)
        
        self.displayUserNameInCell = false
//        let uinfo = RCUserInfo.init(userId: "456", name: "wzq", portrait: "http://pic5.photophoto.cn/20071208/0020033022749625_b.jpg")
//        RCIM.shared().refreshUserInfoCache(uinfo, withUserId: "456")
        
       let r =  RCIM.shared().currentUserInfo
        r?.portraitUri = "http://img.zcool.cn/community/01690955496f930000019ae92f3a4e.jpg"
        r?.name = "jhy"
        RCIM.shared().refreshUserInfoCache(r, withUserId: "123")
        
        
//        let r =  RCIM.shared().currentUserInfo
//        r?.portraitUri = "http://pic5.photophoto.cn/20071208/0020033022749625_b.jpg"
//        r?.name = "wzq"
//        RCIM.shared().refreshUserInfoCache(r, withUserId: "456")
        

//        let uinfo = RCUserInfo.init(userId: "123", name: "jhy", portrait: "http://img2.imgtn.bdimg.com/it/u=241002579,910709915&fm=27&gp=0.jpg")
//        RCIM.shared().refreshUserInfoCache(uinfo, withUserId: "123")
//        let r =  RCIM.shared().currentUserInfo
//        r?.portraitUri = "http://pic5.photophoto.cn/20071208/0020033022749625_b.jpg"
//        r?.name = "wzq"
//        RCIM.shared().refreshUserInfoCache(r, withUserId: "456")
        
//        let info = RCIM.shared().currentUserInfo
//        print("the current userino is \(info?.name ?? "") \(info?.userId ?? "") \(info?.portraitUri ?? "")")
        // Do any additional setup after loading the view.
        
        let b = UIButton(type: .custom)
        b.setTitle("SEND MSG", for: .normal)
        b.backgroundColor = UIColor.red
        b.addTarget(self, action: #selector(sendmsg(_:)), for: .touchUpInside)
        self.view.addSubview(b)
        b.snp.makeConstraints { (make) in
        
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
    }

    @objc func sendmsg(_ b: UIButton){
        
        let jhymsg = JhyMessage.init()
        jhymsg.jhyName = "i am jason"
        jhymsg.extra  = "i am extra msg"
        
        RCIM.shared().sendMessage(.ConversationType_PRIVATE, targetId: "456", content: jhymsg, pushContent: "你有一条未读消息", pushData: "offline", success: { (suc) in
            
            print("ddd\(suc)")
            
        }) { (errcode, fail) in
            
            print("err \(errcode) code \(fail)")
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

extension RCChatViewController{
    
    override func rcConversationCollectionView(_ collectionView: UICollectionView!, cellForItemAt indexPath: IndexPath!) -> RCMessageBaseCell! {

        let m = self.conversationDataRepository[indexPath.row]
        let cellid = "jhymsg"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as? JhyMessageCell
        cell?.setDataModel(m as! RCMessageModel)
        return cell!

    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 80)
    }
    
}
