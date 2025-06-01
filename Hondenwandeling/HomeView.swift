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

    init?(from dict: [String: String]) {
        guard let date = dict["date"],
              let duration = dict["duration"],
              let distanceStr = dict["distance"],
              let distance = Double(distanceStr.replacingOccurrences(of: " km", with: "")) else {
            return nil
        }
        self.date = date
        self.duration = duration
        self.distance = distance
        self.mapImageName = "walk_map_placeholder"
        self.location = "Unknown"
        self.speed = "-"
    }
}

struct HomeView: View {
    @State private var recentWalks: [RecentWalk] = []
    let name = UserDefaults.standard.string(forKey: "name") ?? "Guest"

    var monthlyWalks: [WalkData] {
        var monthDict: [String: Double] = [:]
        let dateFormatter = ISO8601DateFormatter()

        for walk in recentWalks {
            if let date = dateFormatter.date(from: walk.date) {
                let monthIndex = Calendar.current.component(.month, from: date) - 1
                let monthName = Calendar.current.monthSymbols[monthIndex]
                monthDict[monthName, default: 0] += walk.distance
            }
        }

        return monthDict.map { WalkData(month: $0.key, kilometers: $0.value) }
            .sorted { Calendar.current.monthSymbols.firstIndex(of: $0.month)! < Calendar.current.monthSymbols.firstIndex(of: $1.month)! }
    }

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
                                    .frame(width: 90, height: 90)
                            }
                            .padding(.horizontal)

                            Text("This Year")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)

                            if !monthlyWalks.isEmpty {
                                Chart(monthlyWalks) { walk in
                                    LineMark(
                                        x: .value("Month", walk.month),
                                        y: .value("Kilometers", walk.kilometers)
                                    )
                                    .foregroundStyle(Color(red: 0.694, green: 0.874, blue: 0.866))
                                    PointMark(
                                        x: .value("Month", walk.month),
                                        y: .value("Kilometers", walk.kilometers)
                                    )
                                    .foregroundStyle(Color(red: 0.694, green: 0.874, blue: 0.866))
                                }
                                .frame(height: 200)
                                .padding(.horizontal)
                            } else {
                                Text("No walk data yet")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            }

                            Spacer()

                            Text("Recent Walks")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)

                            if !recentWalks.isEmpty {
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
                                                        Text("\(walk.distance, specifier: "%.1f") km")
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
                            } else {
                                Text("No recent walks yet")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            }
                        }
                    }

                    VStack {
                        HStack(spacing: 10) {
                            NavigationLink(destination: WalkingRouteView()) {
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

                            NavigationLink(destination: WalkTrackerView()) {
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
        .onAppear {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                if let stored = UserDefaults.standard.array(forKey: "recentWalks") as? [[String: String]] {
                    self.recentWalks = stored.compactMap { RecentWalk(from: $0) }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
