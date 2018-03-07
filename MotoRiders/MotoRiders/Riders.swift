//
//  Riders.swift
//  MotoRiders
//
//  Created by Admin on 02.03.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class RidersStats: Codable {
    let name: String?
    let number: String?
    let bike: String?
    let team: String?
    
    init(name: String?, number: String?, bike: String?, team: String?) {
        self.name = name
        self.number = number
        self.bike = bike
        self.team = team
    }
    
}

class ItemsStats: Codable {
    let items: [RidersStats]
    
    init(items: [RidersStats]) {
        self.items = items
    }
}


