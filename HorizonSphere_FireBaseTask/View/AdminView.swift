//
//  AdminView.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//

import SwiftUI

struct AdminView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var questionsText = ""
    @ObservedObject var vm = InterviewViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Admin Create Interview")
                .font(.title)

            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Questions (comma separated)", text: $questionsText)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Save Interview") {
                let questions = questionsText.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                vm.createInterview(title: title, description: description, questions: questions)
                title = ""
                description = ""
                questionsText = ""
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}
