//
//  LoginView.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var role = "Candidate"
    @State private var errorMessage = ""

    var body: some View {
        if let user = authVM.user, let role = authVM.userRole {
            // Navigate to role-based screen after login/signup
            RoleBasedView(userId: user.uid, role: role)
                .environmentObject(authVM)
        } else {
            VStack {
                if authVM.isLoading {
                    ProgressView("Please wait...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    VStack(spacing: 16) {
                        Text("Login / Sign Up")
                            .font(.title)

                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)

                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Picker("Role", selection: $role) {
                            Text("Candidate").tag("Candidate")
                            Text("Reviewer").tag("Reviewer")
                            Text("Admin").tag("Admin")
                        }
                        .pickerStyle(SegmentedPickerStyle())

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }

                        Button("Sign Up") {
                            handleSignUp()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(authVM.isLoading)

                        Button("Sign In") {
                            handleSignIn()
                        }
                        .buttonStyle(.bordered)
                        .disabled(authVM.isLoading)
                    }
                    .padding()
                }
            }
        }
    }

    // MARK: - Button Actions

    private func handleSignUp() {
        errorMessage = ""
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty."
            return
        }
        guard isValidEmail(email) else {
            errorMessage = "Invalid email format."
            return
        }
        guard isPasswordValid(password) else {
            errorMessage = "Password must be at least 6 characters and include a number."
            return
        }
        authVM.signUp(email: email, password: password, role: role)
    }

    private func handleSignIn() {
        errorMessage = ""
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty."
            return
        }
        guard isValidEmail(email) else {
            errorMessage = "Invalid email format."
            return
        }
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            return
        }
        authVM.signIn(email: email, password: password)
    }

    // MARK: - Validation Helpers

    private func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{6,}$" // at least 6 characters + 1 number
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: password)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
