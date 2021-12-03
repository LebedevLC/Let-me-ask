//
//  Game.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 01.12.2021.
//

import Foundation

final class Game {

    static let shared = Game()

    private(set) var games: GameSession?
    private(set) var score: [Record] = [] {
        didSet {
            recordsCaretaker.save(records: self.score)
        }
    }
    
    private let recordsCaretaker = GameCaretaker()

    private init() {
        self.score = self.recordsCaretaker.retrieveRecords()
    }
    
    func addGame(_ game: GameSession) {
        self.games = game
    }

    func clearGames() {
        self.games = nil
    }
    
    func incrementScore() {
        self.games?.score += 1
    }
    
    func setupQuestionCount(questionCount: Int) {
        self.games?.questionCount = questionCount
    }
    
    func finishGame(username: String) {
        guard
            let games = games,
            games.questionCount > 0
        else {
            debugPrint("Question count must be not zero!")
            return }
        let percentWin = (Double(games.score) / Double(games.questionCount)) * 100
        let score: Record = .init(
            score: games.score,
            questionCount: games.questionCount,
            percentWin: percentWin,
            username: username,
            date: Date().timeIntervalSince1970)
        self.score.append(score)
        self.games = nil
    }
}
