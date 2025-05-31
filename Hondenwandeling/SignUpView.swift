//
//  SignUpView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 30/05/2025.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()

                Text("Create an account")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom, 30)

                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("E.g.: Nick Haegen", text: $name)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(30)
                        .autocapitalization(.none)
                        .padding(.bottom, 15)

                    Text("Email")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("example@gmail.com", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(30)
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

                Button("Create account") {
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    path.append("home")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.694, green: 0.874, blue: 0.866))
                .foregroundColor(.black)
                .cornerRadius(30)
                .padding(.horizontal, 40)

                Spacer()
            }
            .padding()
            .navigationDestination(for: String.self) { value in
                if value == "home" {
                    HomeView()
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}

