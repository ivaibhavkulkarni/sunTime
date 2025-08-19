//
//  ContentView.swift
//  sunTime2
//
//  Created by Vaibhav Kulkarni on 19/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Summary()
                .tabItem {
                    Label("Summary", systemImage: "sun.max")
                }
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
