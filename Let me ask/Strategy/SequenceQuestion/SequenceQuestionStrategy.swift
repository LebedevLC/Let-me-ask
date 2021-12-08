//
//  SequenceQuestionStrategy.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 06.12.2021.
//

import Foundation

enum Sequence {
    case normal, random
}

protocol SequenceQuestionStrategy: AnyObject {
    
    func nextQuestion(selectQuestion: Int, count: Int) -> Int
}
