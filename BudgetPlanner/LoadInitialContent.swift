//
//  LoadInitialContent.swift
//  BudgetPlanner
//
//  Created by Yuzhi Ma on 12/8/19.
//  Copyright © 2019 Yuzhi Ma. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation
 
// Global array of Trans structs
var listOfTrans = [Trans]()
let locationManager = CLLocationManager()

/*
 *************************************
 MARK: - Load Initial Database Content
 *************************************
 */
public func loadInitialDatabaseContent() {
 
    listOfTrans = loadFromMainBundle("Deposit.json")
}
 
/*
****************************************************
MARK: - Get JSON File from Main Bundle and Decode it
****************************************************
*/
func loadFromMainBundle<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
   
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Unable to find \(filename) in main bundle.")
    }
   
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Unable to load \(filename) from main bundle:\n\(error)")
    }
   
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename) as \(T.self):\n\(error)")
    }
}

/*
************************************************************
MARK: - Obtain and Return User's Current Location Coordinate
************************************************************
*/
public func currentLocation() -> CLLocationCoordinate2D {
    /*
     IMPORTANT NOTE: Current GPS location cannot be accurately determined under the iOS Simulator
     on your laptop or desktop computer because those computers do NOT have a GPS antenna.
     Therefore, do NOT expect the code herein to work under the iOS Simulator!
    
     You must deploy your location-aware app to an iOS device to be able to test it properly.
 
     Monitoring the user's current location is a serious privacy issue!
     You are required to get the user's permission in two ways:
    
     (1) requestWhenInUseAuthorization:
     (a) Ask your locationManager to request user's authorization while the app is being used.
     (b) Add a new row in the Info.plist file for "Privacy - Location When In Use Usage Description", for which you specify, e.g.,
     "Photo Album requires monitoring your location only when you are using the app!"
    
     (2) requestAlwaysAuthorization:
     (a) Ask your locationManager to request user's authorization even when the app is not being used.
     (b) Add a new row in the Info.plist file for "Privacy - Location Always Usage Description", for which you specify, e.g.,
     "Photo Album requires monitoring your location even when you are not using your app!"
    
     You select and use only one of these two options depending on your app's requirement.
     */
   
    // Instantiate a CLLocationCoordinate2D object with initial values
    var currentLocationCoordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
   
    /*
     The user can turn off location services on an iOS device in Settings.
     First, you must check to see of it is turned off or not.
     */
    if CLLocationManager.locationServicesEnabled() {
               
        // Set up locationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
       
        // Ask locationManager to obtain the user's current location coordinate
        if let location = locationManager.location {
            currentLocationCoordinate = location.coordinate
        } else {
            print("Unable to obtain user's current location")
        }
       
    } else {
        // Location Services turned off in Settings
    }
    // Stop updating location when not needed to save battery of the device
    locationManager.stopUpdatingLocation()
   
    return currentLocationCoordinate
}
