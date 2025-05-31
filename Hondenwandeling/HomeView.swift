//
//  HomeView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 31/05/2025.
//

import SwiftUI
import Charts

struct WalkData: Identifiable {
    let id = UUID()
    let month: String
    let kilometers: Double
}

struct RecentWalk: Identifiable {
    let id = UUID()
    let date: String
    let distance: Double
}

struct HomeView: View {
    let name = UserDefaults.standard.string(forKey: "name") ?? "Guest"
    
    let monthlyWalks = [
        WalkData(month: "Jan", kilometers: 42),
        WalkData(month: "Feb", kilometers: 38),
        WalkData(month: "Mar", kilometers: 50),
        WalkData(month: "Apr", kilometers: 45),
        WalkData(month: "May", kilometers: 60)
    ]
    
    let recentWalks = [
        RecentWalk(date: "May 30", distance: 5.2),
        RecentWalk(date: "May 29", distance: 4.8),
        RecentWalk(date: "May 28", distance: 6.0)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hello, \(name)!")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("It’s time for another walk")
                        .font(.headline)
                    
                    Text("This Year")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    Chart(monthlyWalks) { walk in
                        BarMark(
                            x: .value("Month", walk.month),
                            y: .value("Kilometers", walk.kilometers)
                        )
                    }
                    .frame(height: 200)
                    .padding()
                    
                    Text("Recent Walks")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    ForEach(recentWalks) { walk in
                        HStack {
                            Text(walk.date)
                            Spacer()
                            Text("\(walk.distance, specifier: "%.1f") km")
                                .bold()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    HomeView()
}
