//
//  TimerCard.swift
//  sunTime2
//
//  Created by Vaibhav Kulkarni on 19/08/25.
//

import SwiftUI

struct TimerCard: View {
    @Binding var isTimerRunning: Bool
    @Binding var elapsedTime: TimeInterval
    let onStartTimer: () -> Void
    let onStopTimer: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Sun Session Timer")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    if isTimerRunning {
                        onStopTimer()
                    } else {
                        onStartTimer()
                    }
                }) {
                    Text(isTimerRunning ? "Stop" : "Start")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(isTimerRunning ? Color.red : Color.orange)
                        .cornerRadius(20)
                }
            }
            
            Text(timeString(from: elapsedTime))
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .foregroundColor(.primary)
                .padding(.vertical, 8)
            
            Text("Track your current sun exposure session")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerCard(
        isTimerRunning: .constant(false),
        elapsedTime: .constant(0),
        onStartTimer: {},
        onStopTimer: {}
    )
}
