//
//  SelectQuestionsCustomStrategy.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 08.12.2021.
//

import Foundation

class SelectQuestionsCustomStrategy: SelectQuestionsStrategy {
    
    func giveMeQuestions() -> [Question] {
        return Game.shared.questions
    }
    
}
