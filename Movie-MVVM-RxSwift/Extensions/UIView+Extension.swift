//
//  UIView+Extension.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    func addBorderView(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    func setCircleView() {
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func addCornerRadius(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
    
    func topCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
    }
    
    func topLeftCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner] // Top left corner respectively
    }
    
    func bottomCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner] // Bottom right corner, Bottom left corner respectively
    }
    
}
