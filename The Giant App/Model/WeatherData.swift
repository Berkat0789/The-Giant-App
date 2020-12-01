//
//  WeatherData.swift
//  The Giant App
//
//  Created by Berkat Bhatti on 11/30/20.
//  Copyright © 2020 Berkat Bhatti. All rights reserved.
//

import Foundation


struct WeatherData: Codable {
    let name: String!
    let main: Temperature!
    let weather: [Conditions]!
}
struct Temperature: Codable {
    let temp: Double!
}
struct Conditions: Codable {
    let id: Int!
    let description: String!
}


