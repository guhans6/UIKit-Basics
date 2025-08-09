//
//  ViewController.swift
//  UIKit Basics
//
//  Created by Guhan on 09/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 36)
        label.textColor = .systemRed
        label.textAlignment = .center
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.layer.borderWidth = 1
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupViews()
    }

    private func setupViews() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

