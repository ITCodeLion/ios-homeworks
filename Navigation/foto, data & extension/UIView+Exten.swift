//
//  UIView+Exten.swift
//  Navigation
//
//  Created by Lev on 04.05.2022.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
// MARK: - vibration:
extension UIView {
    func vibro() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        layer.add(animation, forKey: "position")
    }
}
