//
//  QuestionStorage.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 30.11.2021.
//

import Foundation

class QuestionStorage {
    
    let questions: [Question]
    
    init() {
        questions = [
            Question(question: "2+2=?", answerRight: "4", answer1: "1", answer2: "2", answer3: "3"),
            Question(question: "2+3=?", answerRight: "5", answer1: "11", answer2: "12", answer3: "13"),
            Question(question: "2+4=?", answerRight: "6", answer1: "21", answer2: "22", answer3: "23"),
            Question(question: "2+5=?", answerRight: "7", answer1: "31", answer2: "32", answer3: "33"),
            Question(question: "2+6=?", answerRight: "8", answer1: "41", answer2: "42", answer3: "43")
        ]
    }
}
