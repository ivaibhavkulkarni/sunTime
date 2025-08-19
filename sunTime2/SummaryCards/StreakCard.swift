//
//  StreakCard.swift
//  sunTime2
//
//  Created by Vaibhav Kulkarni on 19/08/25.
//

import SwiftUI

struct StreakCard: View {
    let currentStreak: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Streak")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("\(currentStreak) days")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                Spacer()
                
                Image(systemName: "flame.fill")
                    .font(.title)
                    .foregroundColor(.orange)
            }
            
            HStack(spacing: 8) {
                ForEach(0..<7, id: \.self) { index in
                    Circle()
                        .fill(index < currentStreak ? Color.orange : Color.gray.opacity(0.3))
                        .frame(width: 12, height: 12)
                }
            }
            
            Text("Keep up the great work!")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    StreakCard(currentStreak: 7)
}
