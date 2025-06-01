//
//  HeaderView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 01/06/2025.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String?
    let backAction: () -> Void

    var body: some View {
        HStack {
            Button(action: backAction) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                if let subtitle = subtitle {
                    Text(subtitle)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }
        }
        .padding()
    }
}

