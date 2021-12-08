//
//  SequenceQuestionNormalStrategy.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 06.12.2021.
//

import Foundation

class SequenceQuestionNormalStrategy: SequenceQuestionStrategy {
    
    func nextQuestion(selectQuestion: Int, count: Int) -> Int {
        let nextQuestion: Int
        nextQuestion = selectQuestion + 1 >= count ? 0 : selectQuestion + 1
        return nextQuestion
    }
}
