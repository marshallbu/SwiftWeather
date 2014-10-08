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
    
    var weatherMan = SWForecaster(yourKey: "6c7ee553c3c0ad92a1bb452ebaf6ec15")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationsButton.layer.cornerRadius = 7
        loadingIndicator.startAnimating()
        
        // event listener!
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateWeatherUI:", name: "weatherHasUpdated", object: nil)
        
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
        
        weatherMan.locationManager.startUpdatingLocation()
        
        // println("pressing buttons")
    }
    
    func updateWeatherUI(notification: NSNotification) {
        currentTemperature.text = weatherMan.temperatureString
        currentWeather.text = weatherMan.weatherString
        locationTitle.title = weatherMan.weatherLocation
        weatherIcon.image = UIImage(named: weatherMan.weatherIcon);
        
        // stop the indicator
        loadingIndicator.stopAnimating()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as SavedLocationsTableViewController
        
        nextViewController.tempLocation = locationTitle.title
    }

}

