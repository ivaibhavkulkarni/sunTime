//
//  SunExposureCard.swift
//  sunTime2
//
//  Created by Vaibhav Kulkarni on 19/08/25.
//

import SwiftUI

struct SunRay: Shape {
    let angle: Double
    let length: CGFloat
    let width: CGFloat
    let intensity: Double
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let endPoint = CGPoint(
            x: center.x + Foundation.cos(angle) * length,
            y: center.y + Foundation.sin(angle) * length
        )
        
        var path = Path()
        path.move(to: center)
        path.addLine(to: endPoint)
        
        return path
    }
}

struct VitaminDParticle: View {
    let radius: CGFloat
    let speed: Double
    let size: CGFloat
    @State private var angle: Double = 0
    @State private var opacity: Double = 0.3
    
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.yellow.opacity(0.8),
                        Color.orange.opacity(0.6),
                        Color.clear
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: size
                )
            )
            .frame(width: size, height: size)
            .offset(
                x: Foundation.cos(angle) * radius,
                y: Foundation.sin(angle) * radius
            )
            .opacity(opacity)
            .onAppear {
                withAnimation(.linear(duration: speed).repeatForever(autoreverses: false)) {
                    angle = .pi * 2
                }
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    opacity = 1.0
                }
            }
    }
}

struct OrbitingParticle: View {
    let radius: CGFloat
    let speed: Double
    let size: CGFloat
    let color: Color
    @State private var angle: Double = 0
    
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [color, color.opacity(0.3), Color.clear]),
                    center: .center,
                    startRadius: 0,
                    endRadius: size
                )
            )
            .frame(width: size, height: size)
            .offset(
                x: Foundation.cos(angle) * radius,
                y: Foundation.sin(angle) * radius
            )
            .onAppear {
                withAnimation(.linear(duration: speed).repeatForever(autoreverses: false)) {
                    angle = .pi * 2
                }
            }
    }
}

struct SolarFlare: View {
    @State private var flareIntensity: CGFloat = 0
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addQuadCurve(
                to: CGPoint(x: 20, y: -30),
                control: CGPoint(x: 10, y: -15)
            )
            path.addQuadCurve(
                to: CGPoint(x: 0, y: 0),
                control: CGPoint(x: 10, y: -15)
            )
        }
        .fill(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.orange.opacity(0.8),
                    Color.yellow.opacity(0.6),
                    Color.clear
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .scaleEffect(flareIntensity)
        .opacity(flareIntensity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                flareIntensity = 1.0
            }
        }
    }
}

struct VitaminDSunRaysContainer: View {
    let progress: Double
    @State private var rotationAngle: Double = 0
    @State private var rayIntensity: Double = 0.3
    
    private var skyBackground: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.cyan.opacity(0.6),
                        Color.yellow.opacity(0.3)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.yellow.opacity(0.8),
                                Color.orange.opacity(0.6),
                                Color.yellow.opacity(0.4)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
            )
            .shadow(color: .yellow.opacity(0.3), radius: 10, x: 0, y: 0)
    }
    
    private var sunCore: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.yellow.opacity(0.9),
                            Color.orange.opacity(0.8),
                            Color.orange.opacity(0.4),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 50
                    )
                )
                .frame(width: 100, height: 100)
                .scaleEffect(0.9 + 0.1 * sin(rotationAngle * 2))
                .blur(radius: 1)
            
            Image(systemName: "sun.max.fill")
                .font(.title)
                .foregroundColor(.orange)
                .scaleEffect(1.2)
        }
    }
    

    
    private var vitaminDParticlesOuter: some View {
        ForEach(0..<Int(progress * 8), id: \.self) { index in
            VitaminDParticle(
                radius: 60,
                speed: Double.random(in: 2.0...4.0),
                size: CGFloat.random(in: 6...12)
            )
        }
    }
    
    private var vitaminDParticlesInner: some View {
        ForEach(0..<Int(progress * 12), id: \.self) { index in
            VitaminDParticle(
                radius: 40,
                speed: Double.random(in: 1.5...3.0),
                size: CGFloat.random(in: 3...8)
            )
        }
    }
    
    private var progressIndicator: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.green.opacity(0.8 * progress),
                        Color.green.opacity(0.4 * progress),
                        Color.clear
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 30
                )
            )
            .frame(width: 60, height: 60)
            .scaleEffect(0.5 + 0.5 * progress)
            .opacity(progress)
    }
    
    private var uvIntensityIndicator: some View {
        ForEach(0..<6, id: \.self) { index in
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.purple.opacity(0.6 * progress),
                            Color.blue.opacity(0.4 * progress),
                            Color.clear
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 2, height: 20)
                .rotationEffect(.degrees(Double(index) * 60 + rotationAngle))
                .offset(x: 70, y: 0)
                .opacity(progress)
        }
    }
    
    private var vitaminDMolecules: some View {
        ForEach(0..<Int(progress * 20), id: \.self) { index in
            Text("D")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.green.opacity(0.7))
                .offset(
                    x: CGFloat.random(in: -80...80),
                    y: CGFloat.random(in: -40...40)
                )
                .animation(
                    .easeInOut(duration: Double.random(in: 2...4))
                    .repeatForever(autoreverses: true),
                    value: rotationAngle
                )
        }
    }
    
    var body: some View {
        ZStack {
            skyBackground
            sunCore
            vitaminDParticlesOuter
            vitaminDParticlesInner
            progressIndicator
            uvIntensityIndicator
            vitaminDMolecules
        }
        .onAppear {
            // Sun rotation
            withAnimation(.linear(duration: 10.0).repeatForever(autoreverses: false)) {
                rotationAngle = 360
            }
            // Ray intensity pulsing
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                rayIntensity = 1.0
            }
        }
    }
}

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
                
            }
            
            // Vitamin D Sun Rays container
            VitaminDSunRaysContainer(progress: min(Double(totalSunTime) / 60.0, 1.0))
                .frame(height: 140)
                .padding(.horizontal, 4)
            
            HStack {
                Text("Goal: 60 minutes")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(Int((Double(totalSunTime) / 60.0) * 100))%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    SunExposureCard(totalSunTime: 60)
}
