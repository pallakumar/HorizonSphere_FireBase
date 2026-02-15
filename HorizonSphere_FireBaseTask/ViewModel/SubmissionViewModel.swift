//
//  SubmissionViewModel.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class SubmissionViewModel: ObservableObject {
    @Published var submissions: [Submission] = []
    private let db = Firestore.firestore()

    func uploadAnswer(interviewId: String, question: String, fileURL: URL) {
        let storageRef = Storage.storage().reference().child("answers/\(UUID().uuidString).mov")

        storageRef.putFile(from: fileURL, metadata: nil) { _, error in
            storageRef.downloadURL { url, _ in
                if let url = url {
                    self.db.collection("submissions").addDocument(data: [
                        "interviewId": interviewId,
                        "question": question,
                        "answerUrl": url.absoluteString,
                        "candidateId": Auth.auth().currentUser?.uid ?? ""
                    ])
                }
            }
        }
    }

    func fetchSubmissions(interviewId: String) {
        db.collection("submissions").whereField("interviewId", isEqualTo: interviewId).addSnapshotListener { snapshot, _ in
            if let docs = snapshot?.documents {
                self.submissions = docs.map { doc in
                    let data = doc.data()
                    return Submission(
                        id: doc.documentID,
                        interviewId: data["interviewId"] as? String ?? "",
                        candidateId: data["candidateId"] as? String ?? "",
                        question: data["question"] as? String ?? "",
                        answerUrl: data["answerUrl"] as? String ?? "",
                        score: data["score"] as? Int,
                        comment: data["comment"] as? String
                    )
                }
            }
        }
    }

    func reviewSubmission(submissionId: String, score: Int, comment: String) {
        db.collection("submissions").document(submissionId).updateData([
            "score": score,
            "comment": comment
        ])
    }
}
