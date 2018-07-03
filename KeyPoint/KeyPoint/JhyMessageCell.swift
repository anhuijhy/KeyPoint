//
//  JhyMessageCell.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/7/3.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class JhyMessageCell: RCMessageCell {
    
    lazy var jhyNameL: RCAttributedLabel = {
        
        let l = RCAttributedLabel.init()
        l.backgroundColor = UIColor.red
        return l
    }()
    
    lazy var extraL: RCAttributedLabel = {
        let l = RCAttributedLabel.init()
        return l
    }()
    
    
    override init!(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.initialize()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    
}

extension JhyMessageCell{
    
    override func setDataModel(_ model:RCMessageModel){
        
        super.setDataModel(model)
        let t = model.content as! JhyMessage
        self.jhyNameL.text = t.jhyName
        
    }

    
    /// Mark:- 初始化一些东西
    func initialize() -> Void{
        
        self.messageContentView.addSubview(self.jhyNameL)
        self.messageContentView.addSubview(self.extraL)
        self.jhyNameL.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
}
