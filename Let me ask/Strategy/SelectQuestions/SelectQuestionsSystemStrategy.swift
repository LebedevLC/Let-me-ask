//
//  SelectQuestionsSystemStrategy.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 08.12.2021.
//

import Foundation

class SelectQuestionsSystemStrategy: SelectQuestionsStrategy {
    
    func giveMeQuestions() -> [Question] {
        return QuestionStorage().questions
    }
    
}
