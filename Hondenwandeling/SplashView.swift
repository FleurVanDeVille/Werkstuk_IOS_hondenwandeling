//
//  SplashView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 30/05/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color(red: 0.694, green: 0.874, blue: 0.866)
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    
                    Text("Welcome!")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image("WalkMyDog_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .padding(.bottom, 20)
                        .padding(.top, 25)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
