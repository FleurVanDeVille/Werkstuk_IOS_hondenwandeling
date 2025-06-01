//
//  WalkTrackerView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 01/06/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct WalkTrackerView: View {
    @State private var isWalking = false
    @State private var routeCoordinates: [CLLocationCoordinate2DWrapper] = []
    @State private var elapsedTime: TimeInterval = 0
    @State private var timerRunning = false
    @State private var distance: Double = 0.0
    @State private var showStopAlert = false

    @StateObject private var locationManager = LocationManager()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $locationManager.cameraPosition, interactionModes: [.all]) {
                ForEach(routeCoordinates) { wrappedCoord in
                    Annotation("", coordinate: wrappedCoord.coord) {
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .ignoresSafeArea()
            .mapStyle(.hybrid)

            VStack {
                if !isWalking {
                    VStack {
                        Spacer()
                        Button(action: {
                            startWalk()
                        }) {
                            Text("START")
                                .font(.title)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.694, green: 0.874, blue: 0.866))
                                .foregroundColor(.black)
                                .cornerRadius(30)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 40)
                        }
                    }
                } else {
                    VStack(spacing: 16) {
                        HStack{
                            Text(formattedTime(elapsedTime))
                                .font(.system(size: 34, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)

                            Button(action: togglePause) {
                                Circle()
                                    .fill(Color(red: 0.694, green: 0.874, blue: 0.866))
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Image(systemName: timerRunning ? "pause" : "play")
                                            .foregroundColor(.black)
                                    )
                            }
                        }

                        Text("\(distance, specifier: "%.2f") km")
                            .font(.title)
                            .foregroundColor(.white)

                        Button(action: {
                            showStopAlert = true
                        }) {
                            Text("STOP")
                                .font(.title2)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.694, green: 0.874, blue: 0.866))
                                .foregroundColor(.black)
                                .cornerRadius(30)
                                .padding(.horizontal, 40)
                        }
                        .alert("Are you sure you want to stop?", isPresented: $showStopAlert) {
                            Button("Yes", role: .destructive, action: stopWalk)
                            Button("Cancel", role: .cancel, action: {})
                        }
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(40)                }
            }
        }
        .onReceive(locationManager.$lastLocation) { location in
            guard isWalking, let location = location else { return }
            if let last = routeCoordinates.last {
                let segmentDistance = location.distance(from: CLLocation(latitude: last.coord.latitude, longitude: last.coord.longitude))
                distance += segmentDistance / 1000 // meters to km
            }
            routeCoordinates.append(CLLocationCoordinate2DWrapper(coord: location.coordinate))
        }
        .onReceive(locationManager.timer) { _ in
            if timerRunning {
                elapsedTime += 1
            }
        }
    }

    func startWalk() {
        isWalking = true
        timerRunning = true
        elapsedTime = 0
        distance = 0
        routeCoordinates = []
    }

    func togglePause() {
        timerRunning.toggle()
    }

    func stopWalk() {
        isWalking = false
        timerRunning = false

        let dateString = ISO8601DateFormatter().string(from: Date())
        let newWalk: [String: String] = [
            "date": dateString,
            "duration": formattedTime(elapsedTime),
            "distance": String(format: "%.2f km", distance)
        ]
        var recentWalks = UserDefaults.standard.array(forKey: "recentWalks") as? [[String: String]] ?? []
        recentWalks.insert(newWalk, at: 0)
        UserDefaults.standard.set(recentWalks, forKey: "recentWalks")

        dismiss()
    }

    func formattedTime(_ time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: time) ?? "00:00:00"
    }
}

struct CLLocationCoordinate2DWrapper: Identifiable, Hashable {
    let id = UUID()
    let coord: CLLocationCoordinate2D

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CLLocationCoordinate2DWrapper, rhs: CLLocationCoordinate2DWrapper) -> Bool {
        lhs.id == rhs.id
    }
}



#Preview {
    WalkTrackerView()
}
