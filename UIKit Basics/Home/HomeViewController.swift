//
//  HomeViewController2.swift
//  UIKit Basics
//
//  Created by Guhan on 15/08/25.
//

import UIKit

//UIKIt label shrinks into a loading progress view and all views will be shown while animating
// First Phase - Show normal views
// Second Phase - Show Table/Collection view and some complex views maybe

class HomeViewController: UIViewController {
    
    private let gradientLayer = CAGradientLayer()
    
    lazy var label: GradientLabelView = {
        let label = GradientLabelView()
        label.translatesAutoresizingMaskIntoConstraints =  false
        label.delegate = self
        return label
    }()
    
    lazy var switchView: SwitchDemoView = {
        let switchView = SwitchDemoView()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()
    
    lazy var switchView2: SwitchDemoView = {
        let switchView = SwitchDemoView()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()
    
    lazy var activityIndicatorView: ActivityIndicatorDemoView = {
        let activityIndicatorView = ActivityIndicatorDemoView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    lazy var segmentControlView: SegmentControlDemoView = {
        let segmentControlView = SegmentControlDemoView()
        segmentControlView.translatesAutoresizingMaskIntoConstraints = false
        return segmentControlView
    }()
    
    lazy var sliderDemoView: SliderDemoView = {
        let sliderView = SliderDemoView()
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        return sliderView
    }()
    
    lazy var textFieldDemoView: TextFieldDemoView = {
        let sliderView = TextFieldDemoView()
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        return sliderView
    }()
    
    lazy var progressView : ProgressDemoView = {
        let progressView = ProgressDemoView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    lazy var buttonDemoView: ButtonDemoView = {
        let buttonView = ButtonDemoView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        return buttonView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        setupViews()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        gradientLayer.locations = [0.0, 0.3, 0.6, 1.0]
        gradientLayer.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.systemBackground.cgColor,
            UIColor.systemBackground.cgColor,
//            UIColor.systemBackground.cgColor,
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupViews() {
        setupLabel()
        setupSwitchView()
        setupActivityIndicatorView()
        dummyLeftIndicatorView()
        dummyLeftSwitchView()
        setupTextField()
        setupProgressView()
        setupButton()
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.setText("UIKit")
        label.setFont(.systemFont(ofSize: 60, weight: .black))
        label.setColor(.label)
        label.setGradientColors([
            rgba(81,148,254,255),
            rgba(136,85,238,255),
            rgba(220,91,167,255)
        ])
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupSwitchView() {
        view.addSubview(switchView)
        switchView.alpha = 0
        
        NSLayoutConstraint.activate([
            switchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            switchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            // use multiplier to adjust according to ipad and iphone width
            switchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38),
            switchView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38)
        ])
    }
    
    private func setupActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.alpha = 0
        
        NSLayoutConstraint.activate([
            activityIndicatorView.trailingAnchor.constraint(equalTo: switchView.trailingAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: switchView.bottomAnchor, constant: 20),
            activityIndicatorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38),
            activityIndicatorView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38)
        ])
    }
    
    private func dummyLeftIndicatorView() {
        view.addSubview(sliderDemoView)
        sliderDemoView.alpha = 0
        
        NSLayoutConstraint.activate([
            sliderDemoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            sliderDemoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            sliderDemoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38),
            sliderDemoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38)
        ])
    }
    
    private func dummyLeftSwitchView() {
        view.addSubview(segmentControlView)
        segmentControlView.alpha = 0
        
        NSLayoutConstraint.activate([
            segmentControlView.leadingAnchor.constraint(equalTo: sliderDemoView.leadingAnchor),
            segmentControlView.topAnchor.constraint(equalTo: sliderDemoView.bottomAnchor, constant: 20),
            segmentControlView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38),
            segmentControlView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38)
        ])
    }
    
    private func setupTextField() {
        view.addSubview(textFieldDemoView)
        textFieldDemoView.alpha = 0
        
        NSLayoutConstraint.activate([
            textFieldDemoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldDemoView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            textFieldDemoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            textFieldDemoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])
    }
    
    private func setupProgressView() {
        view.addSubview(progressView)
        progressView.alpha = 0
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: textFieldDemoView.bottomAnchor, constant: 20),
            progressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            progressView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])
    }
    
    private func setupButton() {
        view.addSubview(buttonDemoView)
        buttonDemoView.alpha = 0
        
        NSLayoutConstraint.activate([
            buttonDemoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonDemoView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20),
            buttonDemoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            buttonDemoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])
    }

}

extension HomeViewController: GradientLabelDelegate {
    func gradientLabelDidTap() {
        animateBackgroundGradient()
    }
    
    private func animateBackgroundGradient() {
        //        let toColors: [CGColor] = GradientColorSet.shared.triColorSet.map { $0.cgColor }
        let toColors: [CGColor] = GradientColorSet.shared.triColorSet.map { $0.cgColor }
        
        // Create smooth animation
        let animation = CABasicAnimation(keyPath: "colors")
        //        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 2.5
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        gradientLayer.add(animation, forKey: "colorChange")
        
        animateView(switchView, transformX: 200, transformY: 0)
        animateView(activityIndicatorView, transformX: 0, transformY: 100)
        animateView(segmentControlView, transformX: 0, transformY: -100)
        animateView(sliderDemoView, transformX: -200, transformY: 0)
        animateView(textFieldDemoView, transformX: 0, transformY: 300, scale: 2)
        animateView(progressView, transformX: 0, transformY: 320, scale: 2.1)
        animateView(buttonDemoView, transformX: 0, transformY: 330, scale: 2.2)
        
        // MARK: update model layer so it stays in final state after animation
        //gradientLayer.colors = toColors
    }
    
    private func animateView(_ view: DemoView, transformX x: CGFloat, transformY y: CGFloat, scale: CGFloat = 1) {
        DispatchQueue.main.async {
            let translation = CGAffineTransform(translationX: x, y: y)
            let scale = CGAffineTransform(scaleX: scale, y: scale)
            view.transform = translation.concatenating(scale)
            
            UIView.animate(withDuration: 1,
                           delay: 0,
//                           usingSpringWithDamping: 0.8,
//                           initialSpringVelocity: 0.5,
                           options: .curveEaseOut,
                           animations: {
                view.alpha = 1
                view.transform = .identity
            }, completion: { _ in
                view.startAnimating()
            })
        }
    }
}
