//
//  SWForecaster.swift
//  SwiftWeather
//
//  Created by Chris Slowik on 9/28/14.
//  Copyright (c) 2014 Chris Slowik. All rights reserved.
//

import Foundation
import CoreLocation

class SWForecaster: NSObject, CLLocationManagerDelegate {
    
    // properties
    var currTemperature : Double = 0
    var temperatureString : String = ""
    var weatherLocation : String = ""
    var weatherString   : String = ""
    var weatherIcon     : String = ""
    
    var apiKey : String
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    init(yourKey: String) {
        // set the API Key
        apiKey = yourKey
        
        // super init!!
        super.init()
        
        // initialize locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // if its ios8
        if ( NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 ) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        //println("started updating")
    }
    
    func updateWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let manager = AFHTTPRequestOperationManager()
        let url = "http://api.openweathermap.org/data/2.5/weather"
        //println(url)
        
        let params = ["lat":latitude, "lon":longitude, "APPID":apiKey]
        println(params)
        
        manager.GET(url,
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                //println("JSON: " + responseObject.description!)
                self.updateWeatherSuccess(responseObject as NSDictionary!)
                //println(self.temperatureString)
                //println(self.weatherString)
                //println(self.weatherLocation)
                //println(self.weatherIcon)
                println("weather")
                NSNotificationCenter.defaultCenter().postNotificationName("weatherHasUpdated", object: nil)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
                
                //self.loading.text = "Internet appears down!"
        })
        
    }
    
    
    // update properties
    func updateWeatherSuccess(jsonResult: NSDictionary!) {
        //self.loading.text = nil
        //self.loadingIndicator.hidden = true
        //self.loadingIndicator.stopAnimating()
        
        // If the temperature is able to be read, assume the rest of the json is there too.
        if let tempResult = ((jsonResult["main"]? as NSDictionary)["temp"] as? Double) {
            var temperature: Double
            //self.weatherLocation = (jsonResult["name"] as String)     this crap is broken! free api...
            if let sys = (jsonResult["sys"]? as? NSDictionary) {
                if let country = (sys["country"] as? String) {
                    if (country == "US") {
                        // Convert temperature to Fahrenheit if user is within the US
                        temperature = round(((tempResult - 273.15) * 1.8) + 32)
                    }
                    else {
                        // Otherwise, convert temperature to Celsius
                        temperature = round(tempResult - 273.15)
                    }
                    
                    // Set the temperature property
                    currTemperature = temperature
                    temperatureString = "\(Int(temperature))°"
                }
                
                if let weather = jsonResult["weather"]? as? NSArray {
                    var condition = (weather[0] as NSDictionary)["id"] as Int
                    var sunrise = sys["sunrise"] as Double
                    var sunset = sys["sunset"] as Double
                    
                    // removing ability to check for night, pending response from openweathermap support
                    // sunrise/sunset numbers appear to reset before sunset local, giving false indicator of night
                    var isNight = false
                    var now = NSDate().timeIntervalSince1970
                    println(sunrise)
                    println(sunset)
                    println(now)
                    
                    //if (now < sunrise || now > sunset) {
                    //    isNight = true
                    //}
                    
                    self.updateWeather(condition, isNight: isNight)
                    
                    return
                }
            }
        }
        weatherString = "Unavailable!"
        weatherIcon = "partly-cloudy"
        temperatureString = "--"
        currTemperature = 0
    }

    // converts a received weather condition to an icon name.
    // documentation: http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes
    func updateWeather(condition: Int, isNight: Bool) {
        //thunderstorms
        if (condition < 300) {
            self.weatherIcon = "thunderstorm"
            self.weatherString = "Thunderstorm"
        }
        
        // light rain
        else if (condition < 500) {
            self.weatherIcon = "light-rain"
            self.weatherString = "Light Rain"
        }
        
        //rain
        else if (condition < 600) {
            self.weatherIcon = "rain"
            self.weatherString = "Rain"
            if (condition >= 502 && condition < 510) {
                self.weatherIcon = "heavy-rain"
                self.weatherString = "Heavy Rain"
            }
        }
        
        //snow
        else if (condition < 700) {
            self.weatherIcon = "snow"
            self.weatherString = "Snow"
            if (condition == 611) {
                self.weatherIcon = "sleet"
                self.weatherString = "Sleet"
            }
        }
        
        // fog and other conditions
        else if (condition < 771) {
            self.weatherIcon = "fog"
            self.weatherString = "Fog"
        }
        
        // tornado, squall
        else if (condition < 800) {
            self.weatherIcon = "tornado"
            self.weatherString = "Tornado"
        }
        
        // clear
        else if (condition == 800) {
            if (isNight){
                self.weatherIcon = "clear-night"
                self.weatherString = "Clear Night"
            }
            else {
                self.weatherIcon = "clear-day"
                self.weatherString = "Clear Sky"
            }
        }
            
        // partly cloudy
        else if (condition < 804) {
            if (isNight) {
                self.weatherIcon = "partly-cloudy-night"
            }
            else {
                self.weatherIcon = "partly-cloudy"
            }
            self.weatherString = "Partly Cloudy"
        }
            
        // cloudy
        else if (condition == 804) {
            self.weatherIcon = "cloudy"
            self.weatherString = "Cloudy"
        }
            
        // another tornado check!
        else if (condition == 900) {
            self.weatherIcon = "tornado"
            self.weatherString = "Tornado"
        }
        
        // hurricane
        else if (condition == 901 || condition == 902) {
            self.weatherIcon = "hurricane"
            self.weatherString = "Hurricane"
        }
        
        // cold
        else if (condition == 903) {
            self.weatherIcon = "snow"
            self.weatherString = "Very Cold"
        }
            
        // hot
        else if (condition == 904) {
            self.weatherIcon = "clear-day"
            self.weatherString = "Very Hot"
        }
            
        // wind
        else if (condition == 905) {
            self.weatherIcon = "wind"
            self.weatherString = "Windy"
        }
        
        // hail
        else if (condition == 906) {
            self.weatherIcon = "hail"
            self.weatherString = "Hail"
        }

        // Weather condition is not available
        else {
            self.weatherIcon = ""
            self.weatherString = "unavailable"
        }
    }
    
    func updateLocationName(currentPlacemark : CLPlacemark) {
        weatherLocation = currentPlacemark.locality
        println("location")
        if (weatherIcon != "") { NSNotificationCenter.defaultCenter().postNotificationName("weatherHasUpdated", object: nil) }
    }
    
    //CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.count-1] as CLLocation
        if (location.horizontalAccuracy > 0) {
            locationManager.stopUpdatingLocation()
            updateWeatherInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
            // get the city name
            CLGeocoder().reverseGeocodeLocation(location, completionHandler:
                {(placemarks, error) in
                    if (error != nil) {println("reverse geocode fail: \(error.localizedDescription)")}
                    let pm = placemarks as [CLPlacemark]
                    if pm.count > 0 { self.updateLocationName(placemarks[0] as CLPlacemark) }
            })
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        //self.loading.text = "Can't get your location!"
    }
}
