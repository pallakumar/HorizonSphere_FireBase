//
//  Submission.swift
//  HorizonSphere_FireBaseTask
//
//  Created by Palla Kumar on 14/09/25.
//
import Foundation

struct Submission: Identifiable {
    var id: String
    var interviewId: String
    var candidateId: String
    var question: String
    var answerUrl: String
    var score: Int?
    var comment: String?
}
