//
//  SwiftModernApp.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-10-25.
//

import SwiftUI
import NetworkingKit
import WeatherService
import GitHubService

@main
struct SwiftModernApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: makeWeatherViewModel())
            GitHubUserView(viewModel: makeGithubUserViewModel())
        }
    }
    private func makeWeatherViewModel() -> WeatherViewModel {
        // Replace with your actual OpenWeatherMap API key
        let apiKey = "37dbefc859051431c4e6f73565b304ee"

        let apiClient = DefaultAPIClient()
        let weatherService = WeatherService(apiClient: apiClient, apiKey: apiKey)

        return WeatherViewModel(weatherService: weatherService)
    }

    private func makeGithubUserViewModel() -> GitHubUserViewModel {
        let apiClient = DefaultAPIClient()
        let gitHubService = GitHubService(apiClient: apiClient)
        return GitHubUserViewModel(gitHubService: gitHubService)
    }
}
