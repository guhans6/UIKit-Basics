//
//  ColorUtil.swift
//  UIKit Basics
//
//  Created by Guhan on 17/09/25.
//

import UIKit

class GradientColorSet {
    
    static let shared = GradientColorSet()
    
    private init() {}
    
    let twoColorSet1: [UIColor] = [
        rgba(185,216,249,255),
        rgba(209,178,243,255)
    ]
    
    let twoColorSet2: [UIColor] = [
        rgba(174,233,255,255),
        rgba(242,183,238,255)
    ]
    
    let triColorSet: [UIColor] = [
        rgba(191, 230, 255, 255),   // light blue
        rgba(209, 199, 242, 255),   // lavender
        rgba(255, 191, 230, 255)    // pink
    ]
    
    let triWhiteColorSet: [UIColor] = [
        UIColor.systemBackground,
        UIColor.systemBackground,
        UIColor.systemBackground
    ]
        
    let quadColorSet: [UIColor] = [
        UIColor.systemTeal.withAlphaComponent(0.9),   // top-left light blue
        UIColor.systemPurple.withAlphaComponent(0.9), // right side purple
        UIColor.systemPink.withAlphaComponent(0.8),   // bottom-right pink
        UIColor.systemGreen.withAlphaComponent(0.7),  // bottom-left green tint
        UIColor.white.withAlphaComponent(0.5)         // soft white glow center
    ]
    
    let quadColorSet2: [UIColor] = [
        rgba(241,187,238,255),
        rgba(186,216,250,255),
        rgba(239,195,239,255),
        rgba(168,227,254,255)
    ]
}
