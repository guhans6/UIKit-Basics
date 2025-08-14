//
//  GradientLabel.swift
//  UIKit Basics
//
//  Created by Guhan on 13/08/25.
//

import UIKit

protocol GradientLabelDelegate: AnyObject {
    func gradientLabelDidTap()
}

class GradientLabel: UILabel {
    
    private let gradientLayer = CAGradientLayer()
    
    weak var delegate: GradientLabelDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        setupTap()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        setupTap()
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.blue.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.addSublayer(gradientLayer)
    }
    
    private func setupTap() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
        // Create mask from text
        if let text = text, let font = font {
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
            (text as NSString).draw(in: bounds, withAttributes: [.font: font])
            let maskImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
            UIGraphicsEndImageContext()
            
            let maskLayer = CALayer()
            maskLayer.frame = bounds
            maskLayer.contents = maskImage
            gradientLayer.mask = maskLayer
        }
    }
    
    @objc private func labelTapped() {
        animateScale()
        animateGradient()
//        animateGradientVertical()
    }
    
    private func animateScale() {
        UIView.animate(withDuration: 1,
                       animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.transform = .identity
            } completion: { _ in
                self.delegate?.gradientLabelDidTap()
            }

        }
    }
    
    private func animateGradient() {
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.fromValue = gradientLayer.startPoint
        animation.toValue = CGPoint(x: 0, y: 1) // shift horizontally
        animation.duration = 1.0
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        gradientLayer.add(animation, forKey: "startPointShift")
        
        let endPointAnimation = CABasicAnimation(keyPath: "endPoint")
        endPointAnimation.fromValue = gradientLayer.endPoint
        endPointAnimation.toValue = CGPoint(x: 1, y: 0) // shift accordingly
        endPointAnimation.duration = 1.0
        endPointAnimation.autoreverses = true
        endPointAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        gradientLayer.add(endPointAnimation, forKey: "endPointShift")
    }
    
}


//Apple often uses:
//
//Pink → Purple → Blue
//
//Blue → Cyan → Green
//
//Orange → Pink
//
//Dark Blue → Purple
