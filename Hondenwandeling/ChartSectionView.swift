//
//  ChartSectionView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 01/06/2025.
//


import SwiftUI
import Charts

struct ChartSectionView: View {
    let monthlyWalks: [WalkData]

    var body: some View {
        VStack(alignment: .leading) {
            Text("This Year")
                .font(.title2)
                .bold()
                .padding(.horizontal)

            if monthlyWalks.isEmpty {
                Text("No walk data yet")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
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
            }
        }
    }
}
