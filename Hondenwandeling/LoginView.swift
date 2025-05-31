//
//  LoginView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 30/05/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginFailed = false
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

    init() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Text("Login")
                    .font(.system(size: 45, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom, 5)

                Text("Hi! Welcome back, you’ve been missed")
                
                NavigationLink("No account? Sign Up", destination: SignUpView())
                    .padding(.bottom, 40)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Email")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("example@gmail.com", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(30)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.bottom, 15)

                    
                    Text("Password")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    SecureField("••••••••••", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
                
                if loginFailed {
                    Text("Invalid email or password")
                        .foregroundColor(.red)
                }

                Button("Login") {
                    let savedEmail = UserDefaults.standard.string(forKey: "email")
                    let savedPassword = UserDefaults.standard.string(forKey: "password")
                                
                    if savedEmail == email && savedPassword == password {
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            isLoggedIn = true
                    } else {
                            loginFailed = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.694, green: 0.874, blue: 0.866))
                .foregroundColor(.black)
                .cornerRadius(30)
                .padding(.horizontal, 40)

                Spacer()
            }
        }
        .navigationDestination(isPresented: $isLoggedIn) {
            HomeView()
        }
    }
}

#Preview {
    LoginView()
}
