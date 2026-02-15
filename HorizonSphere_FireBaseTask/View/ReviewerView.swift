//
//  ReviewerView.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//

import SwiftUI

struct ReviewerView: View {
    @ObservedObject var vm = SubmissionViewModel()
    @State private var scoreText = ""
    @State private var comment = ""

    var body: some View {
        VStack {
            Text("Reviewer Interview Submitions")
                .font(.title)

            List(vm.submissions) { submission in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Question: \(submission.question)")
                    Link("View Answer", destination: URL(string: submission.answerUrl)!)
                    
                    TextField("Score", text: $scoreText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Comment", text: $comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Submit Review") {
                        if let score = Int(scoreText) {
                            vm.reviewSubmission(submissionId: submission.id, score: score, comment: comment)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .onAppear {
            // For demo: fetch all submissions
            vm.fetchSubmissions(interviewId: "")
        }
    }
}

