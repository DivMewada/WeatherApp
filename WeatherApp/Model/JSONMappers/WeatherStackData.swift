//
//  WeatherStackData.swift
//  WeatherApp
//
//  Created by Divya Patel on 03/05/25.
//

import Foundation


struct WeatherStackContainer: Codable {
    var current: WeatherStackCurrent?
}

struct WeatherStackCurrent: Codable {
    let temperature: Int?
    let weather_descriptions: [String]?
}

struct WeatherStackCondition: Codable {
    var text: String
    var icon: String // icon image url
}
