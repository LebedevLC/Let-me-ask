//
//  SelectQuestionsAllStrategy.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 08.12.2021.
//

import Foundation

class SelectQuestionsAllStrategy: SelectQuestionsStrategy {
    
    func giveMeQuestions() -> [Question] {
        return QuestionStorage().questions + Game.shared.questions
    }
    
}
