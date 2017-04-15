//
//  ViewController.swift
//  EYCircularSlider
//
//  Created by Etjen Ymeraj on 4/14/17.
//  Copyright © 2017 Etjen Ymeraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tracker: CustomProgressBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tracker.sliderTrackerTextField.text = "\(tracker.value)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

