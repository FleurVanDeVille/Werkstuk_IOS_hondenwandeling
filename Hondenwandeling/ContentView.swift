//
//  ContentView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 29/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            NavigationStack {
                ZStack {
                    Color(red: 0.694, green: 0.874, blue: 0.866)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        Text("Welcome!")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        VStack(spacing: 16) {
                            NavigationLink(destination: LoginView()) {
                                Text("Login")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(30)
                            }
                            .padding(.horizontal, 80)
                            
                            NavigationLink(destination: SignUpView()) {
                                Text("Sign up")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                            .padding(.horizontal, 80)
                        }
                        
                        Image("WalkMyDog_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                            .padding(.bottom, 20)
                            .padding(.top, 25)
                    }
                }
            }
        }
}

#Preview {
    ContentView()
}
