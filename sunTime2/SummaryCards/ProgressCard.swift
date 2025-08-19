//
//  ProgressCard.swift
//  sunTime2
//
//  Created by Vaibhav Kulkarni on 19/08/25.
//

import SwiftUI

struct ProgressCard: View {
    let totalSunTime: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("This Week")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(totalSunTime * 7) min")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.orange)
            }
            
            HStack(spacing: 4) {
                ForEach(0..<7, id: \.self) { day in
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.orange.opacity(0.8))
                            .frame(height: CGFloat.random(in: 20...60))
                        
                        Text(["S", "M", "T", "W", "T", "F", "S"][day])
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    ProgressCard(totalSunTime: 45)
}
