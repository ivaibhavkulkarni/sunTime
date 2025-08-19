//
//  WeatherCard.swift
//  sunTime2
//
//  Created by Vaibhav Kulkarni on 19/08/25.
//

import SwiftUI

struct WeatherCard: View {
    let weatherData: WeatherData
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Weather")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(weatherData.condition)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(weatherData.temperature)°")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.orange)
                        Text("UV \(weatherData.uvIndex)")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                }
            }
            
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    WeatherDetail(icon: "humidity", value: "\(weatherData.humidity)%", label: "Humidity")
                    WeatherDetail(icon: "wind", value: "\(weatherData.windSpeed) mph", label: "Wind")
                    WeatherDetail(icon: "lungs.fill", value: "\(weatherData.airQualityIndex)", label: "AQI")
                    WeatherDetail(icon: "leaf.fill", value: weatherData.pollutionLevel, label: "Air Quality")
                    WeatherDetail(icon: "eye.fill", value: "Clear", label: "Visibility")
                    WeatherDetail(icon: "thermometer.sun.fill", value: "Feels 75°", label: "Feels Like")
                }
                .padding(.horizontal, 4)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct WeatherDetail: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.orange)
                .frame(width: 32, height: 32)
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 60)
    }
}

#Preview {
    WeatherCard(weatherData: WeatherData(
        temperature: 72,
        condition: "Sunny",
        uvIndex: 8,
        humidity: 45,
        windSpeed: 8,
        airQualityIndex: 42,
        pollutionLevel: "Good"
    ))
}
