//
//  Untitled.swift
//  WeatherApp
//
//  Created by Divya Patel on 03/05/25.
//

import Foundation

public enum WebServiceControllerError: Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}

public protocol WebServiceController {
    init(fallbackService: WebServiceController?)
    
    var fallbackService: WebServiceController? { get }
    
    func fetchWeatherData(for city: String, completionHandler: @escaping (String?, WebServiceControllerError?) -> Void )
}
