//
//  SequenceQuestionRandomStrategy.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 06.12.2021.
//

import Foundation

class SequenceQuestionRandomStrategy: SequenceQuestionStrategy {
    
    private var indexes: [Int] = []
    
    func nextQuestion(selectQuestion: Int, count: Int) -> Int {
        if indexes.isEmpty {
            indexes = [Int](0..<count)
        }
        guard let rand = indexes.randomElement() else {
            return -1
        }
        if let removeIndex = indexes.firstIndex(where: {$0 == rand}) {
            indexes.remove(at: removeIndex)
        }
        return rand
    }

}
