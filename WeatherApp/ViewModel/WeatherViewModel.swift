//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Divya Patel on 03/05/25.
//

import Foundation


class WeatherViewModel:  ObservableObject {
    private let weatherService = OpenWeatherMapController(fallbackService: WeatherStackController())
    
    @Published var weatherInfo = ""
    
    func fetch(city: String) {
        weatherService.fetchWeatherData(for: city) { info, error in
            guard error == nil,
                  let weatherInfo = info else {
                DispatchQueue.main.async {
                    self.weatherInfo = "Could not retrieve weather info for \(city)"
                }
                return
            }
            
            DispatchQueue.main.async {
                self.weatherInfo = weatherInfo
            }
        }
    }
}
