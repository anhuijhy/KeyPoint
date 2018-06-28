//
//  CommentHeaderView.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/14.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import SnapKit
class CommentHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    lazy var headerIcon: UIImageView = {
        
        let icon = UIImageView.init()
        return icon
    }()
    
    lazy var headerTitle: UILabel = {
       
        let title = UILabel.init()
        
        return title
    }()
    
    lazy var desL: UILabel = {
        let desL = UILabel.init()
        return desL
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentHeaderView{
    
    func setUpUI(){
        
        self.addSubview(self.headerIcon)
        self.addSubview(self.headerTitle)
        self.addSubview(self.desL)
        self.laySubUI()
    }
    
    func laySubUI() -> Void {
        
        headerIcon.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(60)
        }
        
        headerTitle.snp.makeConstraints { (make) in
            
            make.left.equalTo(headerTitle.snp.right).offset(10)
            make.top.equalTo(headerIcon.snp.top)
            make.right.equalToSuperview().offset(-20)
        }
        
        desL.snp.makeConstraints { (make) in
            
            make.left.equalTo(headerTitle.snp.left)
            make.right.equalToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(20)
        }
        
    }
}

extension CommentHeaderView{
    
    
    func setDataSource(_ dataSource:Any?){
        
        headerIcon.image = #imageLiteral(resourceName: "jhy")
        headerTitle.text = "特朗普"
        desL.text = "添加太沙发上了飞机上的；fjsa9台式 美国一家家中给日本加拿大拿"
    }
    
}
