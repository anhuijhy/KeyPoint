//
//  CommentCell.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/14.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    
    lazy var headerView :CommentHeaderView = {
       
        let h = CommentHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: self.contentView.frame.size.width, height: 100))
         return h
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


extension CommentCell{
    
    func setUpUI(){
        
      self.contentView.addSubview(self.headerView)
        
    }

}

extension CommentCell{
    
    func laySubUI() -> Void{
        
        //...
        
    }
}

extension CommentCell{
    
    
    func setDataSource() -> Void {
        
        self.headerView.setDataSource(nil)
    }
}
