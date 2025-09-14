//
//  CandidateView.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//
import SwiftUI

struct CandidateView: View {
    @ObservedObject var interviewVM = InterviewViewModel()
    @ObservedObject var submissionVM = SubmissionViewModel()

    var body: some View {
        VStack {
            Text("Candidate Interview")
                .font(.title)

            List(interviewVM.interviews) { interview in
                NavigationLink(interview.title) {
                    VStack {
                        Text(interview.description)
                        ForEach(interview.questions, id: \.self) { q in
                            Button("Answer: \(q)") {
                                // For demo, upload a dummy file
                                if let fileURL = Bundle.main.url(forResource: "sample", withExtension: "mov") {
                                    submissionVM.uploadAnswer(interviewId: interview.id, question: q, fileURL: fileURL)
                                }
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            interviewVM.fetchInterviews()
        }
    }
}
