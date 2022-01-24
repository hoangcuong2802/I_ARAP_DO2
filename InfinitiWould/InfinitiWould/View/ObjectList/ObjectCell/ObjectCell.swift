//
//  ObjectCell.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/23.
//

import UIKit

class ObjectCell: UITableViewCell {

    
    @IBOutlet weak var lbId: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbObjName: UILabel!
    @IBOutlet weak var lbMsg: UILabel!
    @IBOutlet weak var btTalk: CustomButton!
    @IBOutlet weak var lbNewMsgYn: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(obj:ObjectItem){
        lbId.text = String(obj.prjctId)
        lbStatus.text = obj.objStt.toStatus()
        lbObjName.text = obj.objNm
        lbMsg.text = "메세지"
        lbNewMsgYn.isHidden = (obj.newMsgYn != "Y")
    }

}
