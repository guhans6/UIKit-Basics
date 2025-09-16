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
    private var maskLayer = CALayer()
    
    weak var delegate: GradientLabelDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
//        setupTap()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        setupTap()
    }
    
    private func setupGradient() {
        // Default gradient colors
        setGradientColors(nil)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.addSublayer(gradientLayer)
    }
    
    /// Allows you to set custom gradient colors (defaults provided if nil)
    func setGradientColors(_ colors: [UIColor]?) {
        gradientLayer.colors = (colors ?? [
            UIColor.systemPink,
            UIColor.systemPurple,
            UIColor.systemBlue
        ]).map { $0.cgColor }
    }
    
    func showGradient() {
        UIView.animate(withDuration: 0.4) {
            self.gradientLayer.opacity = 1
            self.textColor = .clear // let gradient show through
        }
    }
    
    func hideGradient() {
        UIView.animate(withDuration: 0.4) {
            self.gradientLayer.opacity = 0
            self.textColor = .black
        }
    }
    
    private func setupTap() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
        if let text = text, let font = font {
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
            (text as NSString).draw(in: bounds, withAttributes: [.font: font])
            let maskImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
            UIGraphicsEndImageContext()
            
            maskLayer.frame = bounds
            maskLayer.contents = maskImage
            gradientLayer.mask = maskLayer
        }
    }
    
    @objc private func labelTapped() {
        showGradient()
        animateGradient()
        delegate?.gradientLabelDidTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.hideGradient()
        }
    }
    
    func animateGradient() {
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.fromValue = gradientLayer.startPoint
        animation.toValue = CGPoint(x: 0, y: 1)
        animation.duration = 1.0
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        gradientLayer.add(animation, forKey: "startPointShift")
        
        let endPointAnimation = CABasicAnimation(keyPath: "endPoint")
        endPointAnimation.fromValue = gradientLayer.endPoint
        endPointAnimation.toValue = CGPoint(x: 1, y: 0)
        endPointAnimation.duration = 1.0
        endPointAnimation.autoreverses = true
        endPointAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        gradientLayer.add(endPointAnimation, forKey: "endPointShift")
    }
}

/// A drop-in gradient "label" implemented as a UIView.
/// - Starts with black text (baseLabel).
/// - On showGradient() it crossfades to a gradient-rendered text (gradientView).
/// - You can provide custom gradient colors (defaults used if nil).
class GradientLabelView: UIView {
    
    private let normalLabel = UILabel()
    private let gradientLabel = GradientLabel() // reuse your gradient label class
    
    weak var delegate: GradientLabelDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        normalLabel.textAlignment = .center
        normalLabel.textColor = .black
//        normalLabel.adjustsFontForContentSizeCategory = true
        
        gradientLabel.alpha = 0 // hidden initially
        
        addSubview(gradientLabel)
        addSubview(normalLabel)
        
        normalLabel.translatesAutoresizingMaskIntoConstraints = false
        gradientLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            normalLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            normalLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            normalLabel.topAnchor.constraint(equalTo: topAnchor),
            normalLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            gradientLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientLabel.topAnchor.constraint(equalTo: topAnchor),
            gradientLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        // Gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleGradient))
        addGestureRecognizer(tap)
    }
    
    func setText(_ text: String) {
        normalLabel.text = text
        gradientLabel.text = text
    }
    
    func setFont(_ font: UIFont) {
        normalLabel.font = font
        gradientLabel.font = font
    }
    
    func setColor(_ color: UIColor) {
        normalLabel.textColor = color
    }
    
    func setGradientColors(_ colors: [UIColor]?) {
        gradientLabel.setGradientColors(colors)
    }
    
    @objc private func toggleGradient() {
        UIView.animate(withDuration: 1,
                       delay: 0.1,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
            // fade cross
            self.normalLabel.alpha = self.normalLabel.alpha == 1 ? 0 : 1
            self.gradientLabel.alpha = self.gradientLabel.alpha == 1 ? 0 : 1
            
            // slight scale up during transition
            self.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
            
            self.delegate?.gradientLabelDidTap()
            
            // animate gradient motion
            self.gradientLabel.animateGradient()
        }, completion: { _ in
            // revert scale smoothly back to identity
            UIView.animate(withDuration: 0.6) {
                self.transform = .identity
            }
//            self.delegate?.gradientLabelDidTap()
        })
    }

}


// Notes:
// UIView.transition(with: self, duration: 0.75, options: .curveEaseOut) { previously used for transition
