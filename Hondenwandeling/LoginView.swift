//
//  LoginView.swift
//  Hondenwandeling
//
//  Created by Fleur Van De Ville on 30/05/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Text("Login")
                    .font(.system(size: 45, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom, 5)

                Text("Hi! Welcome back, you’ve been missed")
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

                Button(action: {
                    // Handle login action
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.694, green: 0.874, blue: 0.866))
                        .foregroundColor(.black)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 80)

                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
