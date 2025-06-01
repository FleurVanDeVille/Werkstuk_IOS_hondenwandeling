//
//  RouteRow.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 01/06/2025.
//

import SwiftUI

struct RouteRow: View {
    let route: WalkRoute

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("\(route.distance_km, specifier: "%.1f") km")
                    .font(.headline)
                Text(route.name)
                    .foregroundColor(.black)
                Text(route.type.capitalized)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "map.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

