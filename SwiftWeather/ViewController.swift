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
    @IBOutlet weak var locationTitle: UINavigationItem!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationsButton.layer.cornerRadius = 7
        loadingIndicator.startAnimating()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "translucentHeader"), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Open Sans", size: 21), NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // create gesture recognizer for weather loading
        let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        weatherIcon.addGestureRecognizer(singleTap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        // spin the loading indicator
        loadingIndicator.startAnimating()
        
        // println("pressing buttons")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as SavedLocationsTableViewController
        
        nextViewController.tempLocation = locationTitle.title
    }

}

