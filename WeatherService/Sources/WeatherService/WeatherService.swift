// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import NetworkingKit

public protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherResponse
}

public final class WeatherService: WeatherServiceProtocol {
    private let apiClient: APIClient
    private let apiKey: String
    
    public init(apiClient: APIClient, apiKey: String) {
        self.apiClient = apiClient
        self.apiKey = apiKey
    }
    
    public func fetchWeather(for city: String) async throws -> WeatherResponse {
        let endpoint = WeatherEndpoint(city: city, apiKey: apiKey)
        return try await apiClient.request(endpoint, responseType: WeatherResponse.self)
    }
}
