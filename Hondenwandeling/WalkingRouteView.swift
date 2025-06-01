//
//  WalkingRouteView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 30/05/2025.
//

import SwiftUI

struct WalkRoute: Identifiable {
    let id = UUID()
    let distance: Double
    let name: String
    let mapImageName: String
}

struct WalkingRouteView: View {
    let location = "Halle"
    
    let recommendedRoutes = [
        WalkRoute(distance: 8.3, name: "Hallerbos", mapImageName: ""),
        WalkRoute(distance: 8.3, name: "Hallerbos", mapImageName: ""),
        WalkRoute(distance: 8.3, name: "Hallerbos", mapImageName: ""),
        WalkRoute(distance: 8.3, name: "Hallerbos", mapImageName: ""),
        WalkRoute(distance: 8.3, name: "Hallerbos", mapImageName: "")
    ]
    
    var body: some View {
        ZStack {
            Color(red: 0.694, green: 0.874, blue: 0.866)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        // navigatie nog toevoegen om terug te gaan
                    }) {
                        Image("arrow")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("Dog walking routes")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                Text("Location: \(location)")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(recommendedRoutes) { route in
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(route.distance, specifier: "%.1f") km")
                                        .font(.headline)
                                    Text(route.name)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                // Hier moet nog een foto van de route
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    WalkingRouteView()
}
