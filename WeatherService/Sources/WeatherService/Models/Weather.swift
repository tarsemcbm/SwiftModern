//
//  Weather.swift
//  WeatherService
//
//  Created by Tarsem on 2025-11-01.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
public struct WeatherResponse: Codable, Hashable {
    public let coord: Coord
    public let weather: [Weather]
    public let base: String
    public let main: Main
    public let visibility: Int
    public let wind: Coord
    public let clouds: Clouds
    public let dt: Int
    public let sys: Sys
    public let timezone, id: Int
    public let name: String
    public let cod: Int
}

// MARK: - Clouds
public struct Clouds: Codable, Hashable {
    public let all: Int
}

// MARK: - Coord
public struct Coord: Codable, Hashable {
}

// MARK: - Main
public struct Main: Codable, Hashable {
    public let temp, feelsLike, tempMin, tempMax: Double
    public let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
public struct Sys: Codable, Hashable {
    public let type, id: Int
    public let country: String?
    public let sunrise, sunset: Int
}

// MARK: - Weather
public struct Weather: Codable, Hashable {
    public let id: Int
    public let main, description, icon: String
}
