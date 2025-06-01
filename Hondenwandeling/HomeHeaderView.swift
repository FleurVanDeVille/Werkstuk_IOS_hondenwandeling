//
//  HomeHeaderView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 01/06/2025.
//


import SwiftUI

struct HomeHeaderView: View {
    let name: String

    var body: some View {
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
    }
}
