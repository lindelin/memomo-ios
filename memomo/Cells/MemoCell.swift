//
//  MemoCell.swift
//  memomo
//
//  Created by Jie Wu on 2018/10/25.
//  Copyright © 2018 lindelin. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var contents: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(memo: Memo) {
        self.title.text = memo.title
        self.info.text = "Update at: \(memo.updatedAt)"
        self.contents.text = memo.contents
    }
}
