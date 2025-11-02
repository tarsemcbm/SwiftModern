//
//  ContentView.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-01.
//

import SwiftUI
import WeatherService

struct WeatherView: View {
    @StateObject private var viewModel: WeatherViewModel
    @State private var cityName = ""

    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Search Bar
                HStack {
                    TextField("Enter city name", text: $cityName)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()

                    Button("Search") {
                        Task {
                            await viewModel.fetchWeather(for: cityName)
                        }
                    }
                    .buttonStyle(.bordered)
                    .disabled(cityName.isEmpty)
                }
                .padding()

                // Content
                if viewModel.isLoading {
                    ProgressView("Loading weather...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if let weather = viewModel.weather {
                    WeatherDetailView(weather: weather)
                } else {
                    Text("Search for a city to see weather")
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .navigationTitle("Weather App")
        }
    }
}
