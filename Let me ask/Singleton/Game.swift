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
    private(set) var sequenceStrategy: Sequence
    private(set) var score: [Record] = [] {
        didSet {
            recordsCaretaker.save(records: self.score)
        }
    }
    
    private let recordsCaretaker = GameCaretaker()

    private init() {
        self.score = self.recordsCaretaker.retrieveRecords()
        self.sequenceStrategy = .normal
    }
    
    func addGame(_ game: GameSession) {
        self.games = game
    }
    
    func selectStrategy(sequence: Sequence) {
        self.sequenceStrategy = sequence
    }

    func clearGame() {
        self.games = nil
    }
    
    func incrementScore() {
        self.games?.score += 1
    }
    
    func setupQuestionCount(questionCount: Int) {
        self.games?.questionCount = questionCount
    }
    
    func finishGame(username: String, percent: Double) {
        guard let games = games else { return }
        let score: Record = .init(
            score: games.score,
            questionCount: games.questionCount,
            percentWin: percent,
            username: username,
            date: Date().timeIntervalSince1970)
        self.score.append(score)
        clearGame()
    }
}
