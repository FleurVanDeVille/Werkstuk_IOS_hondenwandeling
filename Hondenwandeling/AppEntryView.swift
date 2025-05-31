//
//  AppEntryView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 31/05/2025.
//

import SwiftUI

struct AppEntryView: View {
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    var body: some View {
        NavigationStack {
            if isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
