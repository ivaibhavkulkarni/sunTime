//
//  SunExposureCard.swift
//  sunTime2
//
//  Created by Vaibhav Kulkarni on 19/08/25.
//

import SwiftUI

struct SunExposureCard: View {
    let totalSunTime: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Today's Sun Exposure")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("\(totalSunTime) minutes")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                Spacer()
                
                Image(systemName: "sun.max.fill")
                    .font(.title)
                    .foregroundColor(.orange)
            }
            
            ProgressView(value: Double(totalSunTime), total: 60)
                .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                .scaleEffect(x: 1, y: 2, anchor: .center)
            
            Text("Goal: 60 minutes")
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
    SunExposureCard(totalSunTime: 45)
}
