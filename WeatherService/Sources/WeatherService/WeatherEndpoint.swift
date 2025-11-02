//
//  WeatherEndpoint.swift
//  WeatherService
//
//  Created by Tarsem on 2025-11-01.
//

import Foundation
import NetworkingKit

struct WeatherEndpoint: Endpoint {
    let city: String
    let apiKey: String
    
    var baseURL: String {
        "https://api.openweathermap.org"
    }
    
    var path: String {
        "/data/2.5/weather"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
        ]
    }
    
}
