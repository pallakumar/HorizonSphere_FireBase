//
//  RoleBasedView.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//

import SwiftUI

struct RoleBasedView: View {
    var userId: String
    var role: String
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome, \(role)")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                if let email = authVM.user?.email {
                    Text("Logged in as \(email)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Divider()

                // Load role-specific view
                if role == "Admin" {
                    AdminView()
                } else if role == "Candidate" {
                    CandidateView()
                } else if role == "Reviewer" {
                    ReviewerView()
                }

                Spacer()

                Button(action: {
                    authVM.signOut()
                }) {
                    Text("Sign Out")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

