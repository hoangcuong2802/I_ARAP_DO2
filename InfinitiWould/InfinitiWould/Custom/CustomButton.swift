//
//  CustomButton.swift
//  PositionSharing
//
//  Created by DroneOrange on 2021/05/07.
//

import UIKit

class CustomButton:UIButton
{
    var complitionHandler: ((UIButton)->Void)?
}

extension CustomButton{

    @objc private func actionTouchUpInside()
    {
        if let closer = self.complitionHandler
        {
            closer(self)
        }
    }
    
    
    func touchUpInside(completion: @escaping ((UIButton)->Void)){
        self.addTarget(self, action: #selector(actionTouchUpInside), for: .touchUpInside)
        self.complitionHandler = completion
    }
}

extension UIButton {
    private func actionHandler(action:((UIButton) -> Void)? = nil) {
        struct __ { static var action :((UIButton) -> Void)? }
        if action != nil { __.action = action }
        else { __.action?(self) }
    }
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
    func actionHandler(controlEvents control :UIControl.Event, Action action:@escaping (UIButton) -> Void) {
        self.actionHandler(action: action)
        self.addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
}
