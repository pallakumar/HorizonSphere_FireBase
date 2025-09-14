//
//  AuthViewModel.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var userRole: String?
    @Published var isLoading = false

    private let db = Firestore.firestore()

    func signUp(email: String, password: String, role: String) {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    print("SignUp Error: \(error.localizedDescription)")
                    return
                }
                if let user = result?.user {
                    self.db.collection("users").document(user.uid).setData([
                        "role": role,
                        "email": email
                    ])
                    self.user = user
                    self.userRole = role
                }
            }
        }
    }

    func signIn(email: String, password: String) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    print("SignIn Error: \(error.localizedDescription)")
                    return
                }
                self.user = result?.user
                if let uid = result?.user.uid {
                    self.db.collection("users").document(uid).getDocument { snapshot, _ in
                        self.userRole = snapshot?.data()?["role"] as? String
                    }
                }
            }
        }
    }
}
