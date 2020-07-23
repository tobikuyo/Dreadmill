//
//  CircularButton.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 23/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

@IBDesignable
class CircularButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setUpView()
        }
    }

    override func prepareForInterfaceBuilder() {
        setUpView()
    }

    func setUpView() {
        layer.cornerRadius = cornerRadius
    }
}
