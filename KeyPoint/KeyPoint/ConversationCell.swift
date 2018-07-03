//
//  ConversationCell.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/28.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class ConversationCell: RCConversationBaseCell {

    lazy var lab: UILabel = {
        let l = UILabel.init()
        l.backgroundColor = UIColor.red
        l.text = "账号"
        return l
    }()
    
    lazy var icon: UIImageView = {
        
        let icon = UIImageView.init()
        return icon
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpUI()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ConversationCell{
    
    override func setDataModel(_ model: RCConversationModel!) {
        
        
        super.setDataModel(model)

        self.lab.text = model.senderUserId


//        print("the user info is \(model.lastestMessage.senderUserInfo.portraitUri)")
//        self.icon.sd_setImage(with: URL.init(string: model.lastestMessage.senderUserInfo.portraitUri), completed: nil)

    }
    

}

extension ConversationCell{
    
    func setUpUI() -> Void {
        self.contentView.addSubview(self.lab)
        self.contentView.addSubview(self.icon)
        self.icon.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(60)
            
        }
        self.lab.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(120)
        }
    }
    
}
