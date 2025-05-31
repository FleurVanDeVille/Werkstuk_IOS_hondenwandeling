//
//  HomeView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 31/05/2025.
//

import SwiftUI

struct HomeView: View {
    let name = UserDefaults.standard.string(forKey: "name") ?? "Guest"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, \(name)!")
                .font(.largeTitle)
                .bold()
            
            Text("It’s time for another walk")
        }
    }
}

#Preview {
    HomeView()
}
