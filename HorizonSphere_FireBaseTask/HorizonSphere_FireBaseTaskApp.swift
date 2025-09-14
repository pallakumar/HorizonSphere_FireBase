//
//  HorizonSphere_FireBaseTaskApp.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//

//import SwiftUI
//
//@main
//struct HorizonSphere_FireBaseTaskApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
import SwiftUI
import Firebase

@main
struct HorizonSphere_FireBaseTaskApp: App {
    @StateObject var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(authVM)  // share across all views
        }
    }
}
