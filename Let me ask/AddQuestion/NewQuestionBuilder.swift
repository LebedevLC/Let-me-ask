//
//  NewQuestionBuilder.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 09.12.2021.
//

import Foundation

class NewQuestionBuilder {
    
    private var question: String = ""
    private var answerRight: String = ""
    private var answer1: String = ""
    private var answer2: String = ""
    private var answer3: String = ""
    
    func build() -> Question {
        return Question(
            question: question,
            answerRight: answerRight,
            answer1: answer1,
            answer2: answer2,
            answer3: answer3
        )
    }
    
    func setQuestion(_ question: String) {
        self.question = question
    }
    
    func setanswerRight(_ answerRight: String) {
        self.answerRight = answerRight
    }
    
    func setAnswer1(_ answer1: String) {
        self.answer1 = answer1
    }
    
    func setAnswer2(_ answer2: String) {
        self.answer2 = answer2
    }
    
    func setAnswer3(_ answer3: String) {
        self.answer3 = answer3
    }
}
