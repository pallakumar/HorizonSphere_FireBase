//
//  InterviewViewModel.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//
import Foundation
import FirebaseFirestore

class InterviewViewModel: ObservableObject {
    @Published var interviews: [Interview] = []
    private let db = Firestore.firestore()

    func createInterview(title: String, description: String, questions: [String]) {
        db.collection("interviews").addDocument(data: [
            "title": title,
            "description": description,
            "questions": questions
        ])
    }

    func fetchInterviews() {
        db.collection("interviews").addSnapshotListener { snapshot, _ in
            if let docs = snapshot?.documents {
                self.interviews = docs.map { doc in
                    let data = doc.data()
                    return Interview(
                        id: doc.documentID,
                        title: data["title"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        questions: data["questions"] as? [String] ?? []
                    )
                }
            }
        }
    }
}

