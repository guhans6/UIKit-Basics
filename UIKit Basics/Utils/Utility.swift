//
//  Utility.swift
//  UIKit Basics
//
//  Created by Guhan on 17/09/25.
//

import Foundation
import UIKit

func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(red: red/255 , green: green/255, blue: blue/255, alpha: alpha/255)
}
