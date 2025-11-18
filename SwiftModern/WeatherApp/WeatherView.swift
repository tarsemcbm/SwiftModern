//
//  ContentView.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-01.
//

import NetworkingKit
import SwiftUI
import WeatherService

struct WeatherView: View {
    @StateObject private var viewModel: WeatherViewModel
    @State private var cityName = ""

    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {  // ← Make sure this is here
            VStack(spacing: 0) {
                searchBar

                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading weather...")
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    errorView(error)
                    Spacer()
                } else if viewModel.searchHistory.isEmpty {
                    Spacer()
                    emptyStateView
                    Spacer()
                } else {
                    historyList
                }
            }
            .navigationTitle("Weather App")
            .toolbar {
                if !viewModel.searchHistory.isEmpty {
                    Button("Clear") {
                        viewModel.clearHistory()
                    }
                }
            }
        }
    }

    private var searchBar: some View {
        HStack {
            TextField("Enter city name", text: $cityName)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
                .submitLabel(.search)
                .onSubmit {
                    searchWeather()
                }

            Button("Search") {
                searchWeather()
            }
            .buttonStyle(.borderedProminent)
            .disabled(cityName.isEmpty)
        }
        .padding()
    }

    private var historyList: some View {
        List {
            ForEach(viewModel.searchHistory, id: \.id) { weather in
                NavigationLink(value: weather) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(weather.name)
                                .font(.headline)
                            if let country = weather.sys.country {
                                Text(country)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }

                        Spacer()

                        Text("\(Int(weather.main.temp))°C")
                            .font(.title3)
                            .bold()
                    }
                }
            }
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.refreshAll()
        }
        .navigationDestination(for: WeatherResponse.self) { weather in
            WeatherDetailView(weather: weather)
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            Text("Search for a city")
                .font(.headline)
                .foregroundColor(.gray)
        }
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            Text(message)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }

    private func searchWeather() {
        Task {
            await viewModel.fetchWeather(for: cityName)
            cityName = ""
        }
    }
}

#Preview {
    WeatherView(
        viewModel: WeatherViewModel(
            weatherService: WeatherService(
                apiClient: DefaultAPIClient(),
                apiKey: "37dbefc859051431c4e6f73565b304ee"
            )
        )
    )
}
