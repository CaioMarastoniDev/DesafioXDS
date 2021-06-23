//
//  RoundButton.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 22/06/21.
//

import UIKit

extension UIView {
    func roundedLeftTopBottom(){
        self.clipsToBounds = true
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width:self.frame.size.height / 8, height:self.frame.size.height / 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}

extension UIButton {
    func btnCorner() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
}
