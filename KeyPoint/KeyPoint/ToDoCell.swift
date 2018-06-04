//
//  ToDoCell.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/29.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {

    lazy var flagL = { () -> UILabel in
        let l = UILabel.init()
        l.text = "😄"
        return l
    }()
    
    lazy var titleL = {()->UILabel in
        
        let l = UILabel.init()
        l.text = "i'm title"
        return l
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



extension ToDoCell{
    
    func setUpUI() -> Void {
        self.contentView.addSubview(flagL)
        self.contentView.addSubview(titleL)
        flagL.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        titleL.frame = CGRect.init(x: 40, y: 0, width: 90, height: 30)
    }
    
    func configCell(_ m:ToDoModel) -> (){
        flagL.text = m.flag
        titleL.text = m.titleStr
    }
}
