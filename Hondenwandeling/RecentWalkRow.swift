//
//  RecentWalkRow.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 01/06/2025.
//


import SwiftUI

struct RecentWalkRow: View {
    let walk: RecentWalk

    var body: some View {
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
