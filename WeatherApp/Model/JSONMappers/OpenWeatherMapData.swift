//
//  OpenWeatherMapData.swift
//  WeatherApp
//
//  Created by Divya Patel on 03/05/25.
//

import Foundation


// JSON Data > Swift mappings
// The OpenWeatherMap API returns a more verbose JSON response
// The following Swift structures include a subset of the returned data, because we only need the weather description and the temperature - the other details are skipped.
// Check https://openweathermap.org/current for more information.

struct OpenWeatherMapContainer: Codable {
    var weather: [OpenMapWeatherWeather]
    var main: OpenMapWeatherMain
}

struct OpenMapWeatherWeather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct OpenMapWeatherMain: Codable {
    var temp: Float?
}
