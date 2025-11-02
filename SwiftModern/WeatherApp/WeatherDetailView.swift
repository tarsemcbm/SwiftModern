//
//  WeatherDetailView.swift
//  SwiftModern
//
//  Created by Tarsem on 2025-11-01.
//

import SwiftUI
import WeatherService

struct WeatherDetailView: View {
    let weather: WeatherResponse

    var body: some View {
        VStack(spacing: 16) {
            // City Name
            Text(weather.name)
                .font(.largeTitle)
                .bold()

            // Weather Condition
            if let condition = weather.weather.first {
                Text(condition.main)
                    .font(.title2)
                Text(condition.description.capitalized)
                    .foregroundColor(.gray)
            }

            // Temperature
            Text("\(Int(weather.main.temp))°C")
                .font(.system(size: 72, weight: .thin))

            // Details
            HStack(spacing: 40) {
                WeatherInfoItem(
                    title: "Feels Like",
                    value: "\(Int(weather.main.feelsLike))°C"
                )

                WeatherInfoItem(
                    title: "Humidity",
                    value: "\(weather.main.humidity)%"
                )
            }

            HStack(spacing: 40) {
                WeatherInfoItem(
                    title: "Pressure",
                    value: "\(weather.main.pressure) hPa"
                )

                if let country = weather.sys.country {
                    WeatherInfoItem(
                        title: "Country",
                        value: country
                    )
                }
            }
        }
        .padding()
    }
}

struct WeatherInfoItem: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
        }
    }
}
