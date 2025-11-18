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
    @Published var searchText = ""
    @Published var searchHistory = [WeatherResponse]()

    private let weatherService: WeatherServiceProtocol
    private var cancelables = Set<AnyCancellable>()

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        setupDebouncer()
    }
    private func setupDebouncer() {
        $searchText
            .map {
                $0.trimmingCharacters(in: .whitespaces)
            }
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task {
                    await self?.fetchWeather(for: query)
                }
            }
            .store(in: &cancelables)

    }

    func fetchWeather(for city: String) async {
        guard !city.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        weather = nil

        do {
            let result = try await weatherService.fetchWeather(for: city)
            weather = result
            if !searchHistory.contains(where: { $0.name == result.name }) {
                searchHistory.insert(result, at: 0)
            }
        } catch {
            errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
        }

        isLoading = false
    }
    func clearHistory() {
        searchHistory.removeAll()
    }
    func refreshAll() async {
        try? await Task.sleep(nanoseconds: 5000_000_000)
    }
}
