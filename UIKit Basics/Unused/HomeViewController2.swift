//
//  ViewController.swift
//  UIKit Basics
//
//  Created by Guhan on 09/08/25.
//

//import UIKit
//
//class HomeViewController2: UIViewController {
//     
//    lazy var label: GradientLabel = {
//        let label = GradientLabel()
//        label.text = "UIKit"
//        label.translatesAutoresizingMaskIntoConstraints =  false
//        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
//        label.adjustsFontForContentSizeCategory = true
//        label.textColor = .systemRed
//        label.textAlignment = .center
//        label.delegate = self
//        return label
//    }()
//    
//    var titleFrame: CGRect = .zero
//    let customLargeTitleView = UIView()
//    
//    private var titleLabelLeadingConstraint: NSLayoutConstraint?
//    private var titleLabelcenterXConstraint: NSLayoutConstraint?
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemBackground
//        
//        navigationController?.navigationBar.isHidden = true
////        navigationItem.title = "UIKit"
////        navigationController?.navigationBar.prefersLargeTitles = true
//        setGradientNavigationTitle2()
//        
//        setupViews()
//    }
//    
//    private func setupNavigationBar() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(resetLabel))
//    }
//    
//    @objc private func resetLabel() {
//        
//    }
//    
//    private func setupViews() {
//        view.addSubview(label)
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}
//
//extension HomeViewController2: GradientLabelDelegate {
//    func gradientLabelDidTap() {
//        openListViewController()
//    }
//}
//
//extension HomeViewController2 {
//    
//    private func openListViewController() {
//        navigationController?.navigationBar.layoutIfNeeded()
//        
//        //we are taking the old gradient label frame thats why this problem occurs
//        // Solution would be the label should be set fresh whenever calling animation
//        guard let navLabel = (self.navigationItem.titleView)?.subviews.first(where: { $0 is GradientLabel }) else {
//            return
//        }
//        
//        // Get nav label's frame in the coordinate space of self.view
//        let targetFrame = navLabel.convert(navLabel.bounds, to: self.view)
//        titleFrame = targetFrame
//        print("label frame: \(label.frame), \n targetFrame: \(targetFrame)")
//        
//        UIView.animate(withDuration: 0.35, animations: {
//            self.label.frame = targetFrame
//        }, completion: { _ in
//            self.label.isHidden = true
//            self.navigationController?.navigationBar.isHidden = false
//            
//        })
//    }
//    
//    private func openListViewController1() {
//        
//    }
//    
//    private func setGradientNavigationTitle2() {
//        // Add subviews to customLargeTitleView, e.g., a UILabel
//        let titleLabel = GradientLabel()
//        titleLabel.text = "UIKit"
//        titleLabel.font = label.font
//        titleLabel.adjustsFontForContentSizeCategory = true
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        customLargeTitleView.addSubview(titleLabel)
//        //set border for customLargeTitleView
//        customLargeTitleView.layer.borderColor = UIColor.systemGray4.cgColor
//        customLargeTitleView.layer.borderWidth = 1
//        customLargeTitleView.layer.cornerRadius = 10
//        customLargeTitleView.clipsToBounds = true
//
//        titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: customLargeTitleView.leadingAnchor)
//        titleLabelcenterXConstraint = titleLabel.centerXAnchor.constraint(equalTo: customLargeTitleView.centerXAnchor)
//
//        //find device is portrait or landscape
//        if UIDevice.current.orientation.isPortrait {
//            // Portrait
//            titleLabel.font = .preferredFont(forTextStyle: .extraLargeTitle)
//            titleLabelcenterXConstraint?.isActive = false
//            titleLabelLeadingConstraint?.isActive = true
//        } else {
//            // Landscape
//            titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//            titleLabelLeadingConstraint?.isActive = false
//            titleLabelcenterXConstraint?.isActive = true
//        }
//
//        titleLabel.topAnchor.constraint(equalTo: customLargeTitleView.topAnchor, constant: 5).isActive = true
//        
//        navigationItem.titleView = customLargeTitleView
//    }
//    
//    
//    private func showTableView() {
//        let tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(tableView)
//        // configure data source here
//    }
//
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        
//        coordinator.animate(alongsideTransition: { _ in
////            self.setGradientNavigationTitle2()
//            self.updateTitleLabelFrame(size: size)
//        })
//    }
//
//    func updateTitleLabelFrame(size: CGSize) {
//        guard let titleView = navigationItem.titleView,
//              let titleLabel = titleView.subviews.first as? GradientLabel else { return }
//        
//        // Recalculate position for large title or compact title
//        let largeFont = UIFont.systemFont(ofSize: 34, weight: .bold)
//        let smallFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
//        
//        let font = size.width < size.height ? largeFont : smallFont
//        titleLabel.font = font
//        
//        if size.width < size.height {
//            // Portrait
//            titleLabel.font = .preferredFont(forTextStyle: .extraLargeTitle)
//            titleLabelcenterXConstraint?.isActive = false
//            titleLabelLeadingConstraint?.isActive = true
////            titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: customLargeTitleView.leadingAnchor)
//        } else {
//            // Landscape
//            titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//            titleLabelLeadingConstraint?.isActive = false
//            titleLabelcenterXConstraint?.isActive = true
////            titleLabelcenterXConstraint = titleLabel.centerXAnchor.constraint(equalTo: customLargeTitleView.centerXAnchor)
//            
//        }
//        
//        // Force redraw of gradient
//        titleLabel.setNeedsLayout()
//        titleLabel.layoutIfNeeded()
//    }
//
//}
