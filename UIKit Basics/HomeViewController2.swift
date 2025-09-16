//
//  HomeViewController2.swift
//  UIKit Basics
//
//  Created by Guhan on 15/08/25.
//

import UIKit

class HomeViewController2: UIViewController {
    
    private let gradientLayer = CAGradientLayer()
    
    lazy var label: GradientLabelView = {
        let label = GradientLabelView()
        label.translatesAutoresizingMaskIntoConstraints =  false
        label.delegate = self
        return label
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
//        setupGradient()
        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.systemBackground.cgColor
        ]
        topView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    private func setupViews() {
        view.addSubview(topView)
        topView.frame = view.bounds
        topView.addSubview(label)
        label.setText("UIKit")
        label.setFont(.systemFont(ofSize: 60, weight: .black))
        label.setColor(.label)
        label.setGradientColors([
            UIColor(red: 0.00, green: 0.47, blue: 1.00, alpha: 1.0), // blue
            UIColor(red: 0.50, green: 0.00, blue: 1.00, alpha: 1.0), // purple
            UIColor(red: 1.00, green: 0.27, blue: 0.33, alpha: 1.0)  // pink-orange
        ])
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])
    }

}

extension HomeViewController2: GradientLabelDelegate {
    func gradientLabelDidTap() {
        animateBackgroundGradient()
    }
    
    private func animateBackgroundGradient() {
        let toColors: [CGColor] = [
            UIColor(red: 0.75, green: 0.90, blue: 1.00, alpha: 1.0).cgColor, // light blue
            UIColor(red: 0.82, green: 0.78, blue: 0.95, alpha: 1.0).cgColor, // lavender
            UIColor(red: 1.00, green: 0.75, blue: 0.90, alpha: 1.0).cgColor  // pink
        ]

        // Create smooth animation
        let animation = CABasicAnimation(keyPath: "colors")
//        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 1
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        gradientLayer.add(animation, forKey: "colorChange")
        // IMPORTANT: update model layer so it stays in final state after animation
//        gradientLayer.colors = toColors
    }
}
