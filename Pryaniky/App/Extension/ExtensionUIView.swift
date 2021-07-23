//
//  ExtensionUIView.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 23.07.2021.
//

import UIKit

extension UIView {

    func addGTapRecognizer(selector: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }

}
