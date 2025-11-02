//
//  WeatherViewModel.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-01.
//

import Foundation
import WeatherService
import NetworkingKit
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: String) async {
        guard !city.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            weather = try await weatherService.fetchWeather(for: city)
        } catch {
            errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
