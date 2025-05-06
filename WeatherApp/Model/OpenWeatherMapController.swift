//
//  OpenWeatherMapController.swift
//  WeatherApp
//
//  Created by Divya Patel on 03/05/25.
//

import Foundation

private enum API {
    static let key = "c2463645f2e7d5cd984fa5a6077a6132"
}

final class OpenWeatherMapController: WebServiceController {
    var fallbackService: WebServiceController?
    
    init(fallbackService: WebServiceController? = nil) {
        self.fallbackService = fallbackService
    }
    
    
    func fetchWeatherData(for city: String, completionHandler: @escaping (String?, WebServiceControllerError?) -> Void) {
        let endpoint = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=imperial&appid=\(API.key)"
        
        guard let safeURLString = endpoint.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let endpointURL = URL(string: safeURLString) else {
            completionHandler(nil, WebServiceControllerError.invalidURL(endpoint))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: endpointURL, completionHandler: { (data, response, error) -> Void in
            guard error == nil else {
                if let fallback = self.fallbackService {
                    fallback.fetchWeatherData(for: city, completionHandler: completionHandler)
                } else {
                    completionHandler(nil, WebServiceControllerError.forwarded(error!))
                }
                return
            }
            guard let responseData = data else {
                if let fallback = self.fallbackService {
                    fallback.fetchWeatherData(for: city, completionHandler: completionHandler)
                } else {
                    completionHandler(nil, WebServiceControllerError.invalidPayload(endpointURL))
                }
                return
            }

            // decode json
            let decoder = JSONDecoder()
            do {
                let weatherList = try decoder.decode(OpenWeatherMapContainer.self, from: responseData)
                guard let weather = weatherList.weather.first?.main,
                    let temperature = weatherList.main.temp else {
                    completionHandler(nil, WebServiceControllerError.invalidPayload(endpointURL))
                    return
                }

                // compose weather information
                let weatherDescription = "\(weather) \(temperature) °F"
                completionHandler(weatherDescription, nil)
            } catch let error {
                completionHandler(nil, WebServiceControllerError.forwarded(error))
            }
        })
        
        dataTask.resume()
        
    }
}
