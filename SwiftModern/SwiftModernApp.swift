//
//  SwiftModernApp.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-10-25.
//

import SwiftUI
import NetworkingKit
import WeatherService

@main
struct SwiftModernApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: makeViewModel())
        }
    }
    private func makeViewModel() -> WeatherViewModel {
        // Replace with your actual OpenWeatherMap API key
        let apiKey = "37dbefc859051431c4e6f73565b304ee"

        let apiClient = DefaultAPIClient()
        let weatherService = WeatherService(apiClient: apiClient, apiKey: apiKey)

        return WeatherViewModel(weatherService: weatherService)
    }
}
