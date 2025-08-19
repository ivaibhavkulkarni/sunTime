//
//  Summary.swift
//  sunTime2
//
//  Created by Vaibhav Kulkarni on 19/08/25.
//

import SwiftUI

struct Summary: View {
    @StateObject private var timerManager = TimerManager()
    @State private var currentStreak = 7
    @State private var totalSunTime = 45 // minutes
    
    // Mock weather data
    let weatherData = WeatherData(
        temperature: 72,
        condition: "Sunny",
        uvIndex: 8,
        humidity: 45,
        windSpeed: 8,
        airQualityIndex: 42,
        pollutionLevel: "Good"
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header with date
                    HeaderSection()
                    
                    // Weather card
                    WeatherCard(weatherData: weatherData)
                    
                    // Sun exposure stats
                    SunExposureCard(totalSunTime: totalSunTime)
                    
                    // Timer section
                    TimerCard(
                        isTimerRunning: $timerManager.isTimerRunning,
                        elapsedTime: $timerManager.elapsedTime,
                        onStartTimer: timerManager.startTimer,
                        onStopTimer: timerManager.stopTimer
                    )
                    
                    // Streak section
                    StreakCard(currentStreak: currentStreak)
                    
                    // Today's progress
                    ProgressCard(totalSunTime: totalSunTime)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    Summary()
}
