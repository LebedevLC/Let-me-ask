//
//  GameSession.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 01.12.2021.
//

import Foundation

enum MyHelps {
    case auditory
    case halfQuestion
    case callFriend
}

struct GameSession {
    var score: Int
    var questionCount: Int
    var username: String
    var isUsedAuditoryHelp: Bool
    var isUsedHalfQuestionHelp: Bool
    var isUsedCallFriendHelp: Bool
}
