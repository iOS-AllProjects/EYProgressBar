//
//  Extensions.swift
//  EYCircularSlider
//
//  Created by Etjen Ymeraj on 4/15/17.
//  Copyright © 2017 Etjen Ymeraj. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
