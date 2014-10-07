//
//  ViewController.swift
//  SwiftWeather
//
//  Created by Marshall Upshur on 10/6/14.
//  Copyright (c) 2014 Marshall Upshur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationsButton: UIButton!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentWeather: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationsButton.layer.cornerRadius = 7
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

