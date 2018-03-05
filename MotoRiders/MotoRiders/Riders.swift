//
//  Riders.swift
//  MotoRiders
//
//  Created by Admin on 02.03.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import Foundation

struct RidersStats: Decodable {
    let name: String?
    let number: String?
    let bike: String?
    let team: String?
}

struct GlobalStats: Decodable {
    let items: [RidersStats]
}


