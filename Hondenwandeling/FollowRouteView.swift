//
//  FollowRouteView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 01/06/2025.
//

import SwiftUI
import MapKit

struct FollowRouteView: View {
    let route: WalkRoute
    @Binding var path: NavigationPath
    @State private var isWalking = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timerRunning = false
    @State private var showStopAlert = false
    @State private var distance: Double = 0.0
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var locationManager = LocationManager()
    
    func stopWalk() {
        isWalking = false
        timerRunning = false
        path.removeLast(path.count)
    }

    var body: some View {
        ZStack {
            Map(position: $locationManager.cameraPosition) {
                UserAnnotation()
                
                Annotation(route.name, coordinate: CLLocationCoordinate2D(latitude: route.latitude, longitude: route.longitude)) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 15, height: 15)
                }
            }
            .ignoresSafeArea()
            .mapStyle(.hybrid)

            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.horizontal)

                Spacer()

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
                            HStack {
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
                                    .font(.title)
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
                            .padding(.bottom, 20)
                        }
                        .padding(.top, 30)
                        .background(Color.black)
                        .ignoresSafeArea(edges: .bottom)
                    }

                }
            }
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
    }

    func togglePause() {
        timerRunning.toggle()
    }

    func formattedTime(_ time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: time) ?? "00:00:00"
    }

}
