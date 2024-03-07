//
//  UIView+Extensions.swift
//  Crypto
//
//  Created by chandru on 07/03/24.
//

import Foundation
import UIKit

extension UIView {
    
    func addSaveViewTo (
        _ parentView: UIView,
        topOffset: CGFloat = 0,
        leftOffset: CGFloat = 0,
        rightOffset: CGFloat = 0,
        bottomOffset: CGFloat = 0
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: topOffset),
            leftAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leftAnchor, constant: leftOffset),
            rightAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.rightAnchor, constant: -rightOffset),
            bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: -bottomOffset)
        ])
    }
    
    func addViewTo (
        _ parentView: UIView,
        topOffset: CGFloat = 0,
        leftOffset: CGFloat = 0,
        rightOffset: CGFloat = 0,
        bottomOffset: CGFloat = 0
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor, constant: topOffset),
            leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: leftOffset),
            rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -rightOffset),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -bottomOffset)
        ])
    }
    
    func addCenterAlignedViewTo(_ parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ])
    }
}
