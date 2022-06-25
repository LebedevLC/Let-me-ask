//
//  SelectQuestionsStrategy.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 08.12.2021.
//

import Foundation

enum SelectQuestions {
    case system, custom, all
}

protocol SelectQuestionsStrategy: AnyObject {

    func giveMeQuestions() -> [Question]
}
