//
//  HomeView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 31/05/2025.
//

import SwiftUI

struct HomeView: View {
    let username = UserDefaults.standard.string(forKey: "username") ?? "Guest"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, \(username)!")
                .font(.largeTitle)
                .bold()
            
            Text("It’s time for another walk")
        }
    }
}

#Preview {
    HomeView()
}
