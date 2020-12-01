//
//  ForecastData.swift
//  The Giant App
//
//  Created by Berkat Bhatti on 11/30/20.
//  Copyright © 2020 Berkat Bhatti. All rights reserved.
//

import Foundation


struct ForecastData: Codable {
    let list: [Days]!
    let city: City!
}

struct Days : Codable {
    let main: Temperature!
    let weather: [Conditions]!
 
}
struct City: Codable {
    let name :String!
}
