//
//  RecentWalk.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 01/06/2025.
//


import Foundation

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
