//
//  MessageCell.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/02.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel?
    @IBOutlet weak var lbContens: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
