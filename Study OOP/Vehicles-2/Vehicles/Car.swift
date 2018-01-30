//
//  Car.swift
//  Vehicles
//
//  Created by Admin on 29.01.18.
//  Copyright © 2018 Razeware, LLC. All rights reserved.
//

import Foundation


class Car : Vehicle {
    var isConvertible:Bool = false
    var isHatchback:Bool = false
    var hasSunroof:Bool = false
    var numberOfDoors:Int = 0
    
    override init() {
        super.init()
        numberOfWheels = 4
    }
    
    // MARK: - Private method implementations
    private func start() -> String {
        return String(format: "Start power source %@.", powerSource)
    }
    // MARK: - Superclass Overrides
    override func goForward() -> String {
        return String(format: "%@ %@ Then depress gas pedal.", start(), changeGears(newGearName: "Forward"))
    }
    
    override func goBackward() -> String {
        return String(format: "%@ %@ Check your rear view mirror. Then depress gas pedal.", start(), changeGears(newGearName: "Reverse"))
    }
    
    override func stopMoving() -> String {
        return String(format: "Depress brake pedal. %@", changeGears(newGearName: "Park"))
    }
    
    override func makeNoise() -> String {
        return "Beep beep!"
    }
}
