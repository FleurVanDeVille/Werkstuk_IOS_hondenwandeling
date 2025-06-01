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
    let mapImageName: String
    let location: String
    let duration: String
    let speed: String
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
        RecentWalk(date: "May 30", distance: 5.2, mapImageName: "walk_map1", location: "Halle", duration: "30 min", speed: "5 km/h"),
        RecentWalk(date: "May 29", distance: 4.8, mapImageName: "walk_map2", location: "Anderlecht", duration: "28 min", speed: "5.1 km/h"),
        RecentWalk(date: "May 28", distance: 6.0, mapImageName: "walk_map3", location: "Nieuwpoort", duration: "40 min", speed: "5.5 km/h")
    ]

    
    var body: some View {
            NavigationView {
                ZStack {
                    VStack {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Hello, \(name)!")
                                            .font(.largeTitle)
                                            .bold()
                                        Text("It’s time for another walk")
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image("dog_avatar")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                }
                                .padding(.horizontal)
                                
                                
                                Text("This Week")
                                    .font(.title2)
                                    .bold()
                                    .padding(.horizontal)
                                
                                Chart(monthlyWalks) { walk in
                                    LineMark(
                                        x: .value("Month", walk.month),
                                        y: .value("Kilometers", walk.kilometers)
                                    )
                                    PointMark(
                                        x: .value("Month", walk.month),
                                        y: .value("Kilometers", walk.kilometers)
                                    )
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                                
                                Spacer()

                                Text("Recent Walks")
                                    .font(.title2)
                                    .bold()
                                    .padding(.horizontal)
                                
                                VStack(spacing: 15) {
                                    ForEach(recentWalks) { walk in
                                        HStack(spacing: 10) {
                                            Image(walk.mapImageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 80)
                                                .cornerRadius(10)
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("\(walk.location) - \(walk.date)")
                                                    .font(.headline)
                                                
                                                HStack {
                                                    VStack(alignment: .leading) {
                                                        Text("\(walk.duration)")
                                                            .bold()
                                                        Text("Duration")
                                                            .font(.caption)
                                                            .foregroundColor(.gray)
                                                    }
                                                    VStack(alignment: .leading) {
                                                        Text("\(walk.distance, specifier: "%.1f")")
                                                            .bold()
                                                        Text("Distance")
                                                            .font(.caption)
                                                            .foregroundColor(.gray)
                                                    }
                                                    VStack(alignment: .leading) {
                                                        Text("\(walk.speed)")
                                                            .bold()
                                                        Text("Speed")
                                                            .font(.caption)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                            }
                                            Spacer()
                                        }
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(20)
                                        .padding(.horizontal)
                                    }
                                }
                                .padding(.bottom, 80)
                            }
                        }
                        
                        VStack {
                            HStack(spacing: 10) {
                                Button(action: {
                                    // hier moet de navigatie nog komen om naar de WalkingRouteView te gaan
                                }) {
                                    Text("Find a walking route!")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(30)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color(red: 0.694, green: 0.874, blue: 0.866), lineWidth: 3)
                                        )
                                }
                                
                                Button(action: {
                                    // hier moer de navigatie nog komen om naar de map te gaan om zelf een route te starten
                                }) {
                                    Text("Let's go for a walk!")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 0.694, green: 0.874, blue: 0.866))
                                        .foregroundColor(.black)
                                        .cornerRadius(30)
                                }
                            }
                            .padding(.horizontal, 4)
                            .padding(.bottom, 10)
                            .padding(.top, 10)
                        }
                    }
                }
            }
        }
}

#Preview {
    HomeView()
}
