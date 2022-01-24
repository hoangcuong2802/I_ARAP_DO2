//
//  ProjectCell.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/01.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var lbProjNum: UILabel!
    @IBOutlet weak var lbProjName: UILabel!
    @IBOutlet weak var lbProjAddr: UILabel!
    @IBOutlet weak var lbProjDate: UILabel!
    @IBOutlet weak var btProjName: CustomButton!
    @IBOutlet weak var btProjAddr: CustomButton!
    @IBOutlet weak var lbNewMsgYn: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK: - -------------Data Setting
    func setData(obj:ProjectListItem?){
        if let obj = obj{
            lbProjNum.text = "\(obj.prjctId)"
            lbProjName.text = obj.prjctNm
            lbProjAddr.text = obj.addr
            lbProjDate.text = "\(obj.prjctStartDt ?? "") ~ \(obj.prjctEndDt ?? "")"
            lbNewMsgYn.isHidden = (obj.newMsgYn != "Y")
        }
    }
    
}
