//
//  Vehicle.swift
//  Vehicles
//
//  Created by Ray Fix on 9/8/14.
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

import Foundation

class Vehicle {
    var brandName = "null"
    var modelName = "null"
    var modelYear = 0
    var powerSource = "null"
    var numberOfWheels = 0
    
    var vehicleTitle: String {
        return String(format:"%d %@ %@", modelYear, brandName, modelName)
    }
    func goForward() -> String {
        return "null"
    }
    
    func goBackward() -> String {
        return "null"
    }
    
    func stopMoving() -> String {
        return "null"
    }
    
    func turn(degrees:Int) -> String {
        var normalizedDegrees = degrees
        
        //Since there are only 360 degrees in a circle, calculate what a single turn would be.
        let degreesInACircle = 360
        
        if (normalizedDegrees > degreesInACircle || normalizedDegrees < -degreesInACircle) {
            // The % operator returns the remainder after dividing.
            normalizedDegrees = normalizedDegrees % degreesInACircle
        }
        
        return String(format: "Turn %d degrees.", normalizedDegrees)
    }
    
    func changeGears(newGearName:String) -> String {
        return String(format: "Put %@ into %@ gear.",self.modelName, newGearName)
    }
    
    func makeNoise() -> String {
        return "null"
    }
}

