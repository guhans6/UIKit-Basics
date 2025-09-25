//
//  DemoViews.swift
//  UIKit Basics
//
//  Created by Guhan on 17/09/25.
//

import UIKit

///View with blur effect and corner radius
class DemoView: UIView {
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular) // adaptive blur
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupView()
        setupBlurEffect()
    }
    
    func setupView() {
        backgroundColor = .white.withAlphaComponent(0.4) // or black alpha
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        clipsToBounds = true
    }
    
    func setupBlurEffect() {
        addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    //Mark: Override this
    func startAnimating() { }
    
    func stopAnimating() { }
}

class SwitchDemoView: DemoView {
    
    private lazy var toggleSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = false
        uiSwitch.preferredStyle = .automatic
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(toggleSwitch)
        
        //        setupBlurEffect()
        //        blurView.contentView.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            toggleSwitch.centerXAnchor.constraint(equalTo: centerXAnchor),
            toggleSwitch.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    /// Animate the switch turning on and off
    override func startAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.toggleSwitch.setOn(true, animated: true) // turn ON after 1s
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.toggleSwitch.setOn(false, animated: true) // turn OFF after 2.5s
        }
    }
}

class ActivityIndicatorDemoView: DemoView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    override func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}

class SegmentControlDemoView: DemoView {
    
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["One", "Two"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
    
    override func startAnimating() {
        func animateToNextSegment(after seconds: Double, to segmentIndex: Int) {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                UIView.animate(withDuration: 0.3) {
                    self.segmentedControl.selectedSegmentIndex = segmentIndex
                }
            }
        }
        
        animateToNextSegment(after: 1.0, to: 1)
        
        animateToNextSegment(after: 2.0, to: 0)
    }
}

class SliderDemoView: DemoView {
    
    private lazy var slider: UISlider = {    
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(slider)
        
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: centerYAnchor),
            slider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
    
    override func startAnimating() {
        func animateToNextValue(after seconds: Double, to value: Float) {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                UIView.animate(withDuration: 0.3) {
                    self.slider.setValue(value, animated: true)
                }
            }
        }
        
        animateToNextValue(after: 1.0, to: 45)
        
        animateToNextValue(after: 2.0, to: 100)
        
        animateToNextValue(after: 3.0, to: 0)
    }
}

class InsetTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class TextFieldDemoView: DemoView {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text here"
//        textField.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.backgroundColor = .clear
        textField.textColor = .label
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var typingTimer: Timer?      // Timer for typing characters
    private var cursorTimer: Timer?      // Timer for blinking cursor
    
    deinit {
        typingTimer?.invalidate()
        cursorTimer?.invalidate()
    }
    
    override func setupView() {
        super.setupView()
        layer.cornerRadius = 10
        addSubview(textField)
        
        // Create the image view
        let imageView = UIImageView(image: UIImage(systemName: "chevron.left.slash.chevron.right")) // SF Symbol

        // Adjust sizing
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray // optional, applies to SF Symbols

        // Wrap in a container view so there’s padding
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: self.frame.height))
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView.center = containerView.center

        containerView.addSubview(imageView)

        // Assign to textField
        textField.leftView = containerView
        textField.leftViewMode = .always
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor),
            textField.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    override func startAnimating() {
        let textToType = "Hello, world!"
        let delay = 0.2
        
        for (index, char) in textToType.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay * Double(index)) {
                self.textField.text = (self.textField.text ?? "") + String(char)
            }
        }
        
        textField.text = ""
    }
    
//    MARK: Alternative - With cursor blinking
//        override func startAnimating() {
//            let textToType = "Hello, world!"
//            var currentIndex = 0
//            let typingDelay: TimeInterval = 0.2
//            var isCursorVisible = true
//
//            textField.text = "" // clear text first
//
////             1️⃣ Typing timer: adds one character at a time
//            typingTimer = Timer.scheduledTimer(withTimeInterval: typingDelay, repeats: true) { [weak self] timer in
//                guard let self = self else { return }
//                if currentIndex < textToType.count {
//                    let index = textToType.index(textToType.startIndex, offsetBy: currentIndex)
////                     Add next character and append cursor
//                    self.textField.text = String(textToType[..<textToType.index(textToType.startIndex, offsetBy: currentIndex + 1)]) + "|"
//                    currentIndex += 1
//                } else {
////                     Stop typing timer when done
//                    timer.invalidate()
//                }
//            }
//
////             2️⃣ Cursor blinking timer
//            cursorTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
//                guard let self = self else { return }
//                guard var text = self.textField.text else { return }
//
//                if text.last == "|" {
//                    text.removeLast()  // hide cursor
//                } else {
//                    text += "|"         // show cursor
//                }
//                self.textField.text = text
//            }
//        }
    
    //MARK: Alternative - Recursion give more flexiblity over the animation
    //    override func startAnimating() {
    //        let textToType = "Hello, world!"
    //        var currentText = ""
    //        var currentIndex = 0
    //        let delay = 0.2 // seconds between each character
    //
    //        func typeNextCharacter() {
    //            if currentIndex < textToType.count {
    //                let index = textToType.index(textToType.startIndex, offsetBy: currentIndex)
    //                textField.text = (textField.text ?? "") + String(textToType[index])
    //                currentIndex += 1
    //                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
    //                    typeNextCharacter()
    //                }
    //            }
    //        }
    //
    //
    //        textField.text = "" // clear text before typing
    //        typeNextCharacter()
    //    }
}

class ProgressDemoView: DemoView {
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progress = 0
        progressView.backgroundColor = .clear
        return progressView
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()
    
    private let gradient = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = progressView.bounds
    }
    
    override func setupView() {
        super.setupView()
        
        addSubview(progressView)
        
//        Gradient setup
//        gradient.colors = GradientColorSet.shared.triColorSet.map( { $0.cgColor } )
        gradient.colors = [
            rgba(81,148,254,255),
            rgba(136,85,238,255),
            rgba(220,91,167,255)
        ].map({ $0.cgColor })
        gradient.frame = progressView.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        progressView.progressImage = image
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressView.widthAnchor.constraint(equalTo: widthAnchor),
            progressView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        setupProgressLabel()
    }
    
    private func setupProgressLabel() {
        addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func startAnimating() {
        for i in 0...100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i / 27)) {
                let text = "\(i)%"
                self.progressLabel.text = text
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2) {
                    self.progressView.setProgress(Float(i) / 100.0, animated: true)
                    // if i is in range inbetween 40 to 50 change label color
                    if i >= 40 && i < 50 {
                        UIView.transition(with: self.progressLabel, duration: 0.001, options: .transitionCrossDissolve) {
                            self.progressLabel.textColor = .white
                        }
                    }
                }
            }
        }
        
        //reset all
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.progressLabel.text = "0%"
            self.progressView.setProgress(0, animated: true)
            self.progressLabel.textColor = .black
        }
    }
}

class ButtonDemoView: DemoView {
    
    lazy var button: UIButton = {
        
        var title = AttributedString("Click me")
        title.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .trailing
        configuration.image = UIImage(systemName: "hand.rays")
        configuration.attributedTitle = title
        configuration.imagePadding = 10
        
        let button = UIButton(type: .roundedRect)
        button.configuration = configuration
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.setTitleColor(.label, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupView() {
        super.setupView()
        layer.cornerRadius = 16
        addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.widthAnchor.constraint(equalTo: widthAnchor),
            button.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
