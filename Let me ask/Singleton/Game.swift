//
//  Game.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 01.12.2021.
//

import Foundation

final class Game {

    static let shared = Game()

    private(set) var game: GameSession?
    private(set) var sequenceStrategy: Sequence
    private(set) var selectQuestionsStrategy: SelectQuestions
    
    private(set) var score: [Record] = [] {
        didSet {
            recordsCaretaker.saveRecords(records: self.score)
        }
    }
    
    private(set) var questions: [Question] = [] {
        didSet {
            questionsCaretaker.saveQuestions(questions: self.questions)
        }
    }
    
    private let recordsCaretaker = RecordsCaretaker()
    private let questionsCaretaker = QuestionCaretaker()

    private init() {
        self.score = self.recordsCaretaker.retrieveRecords()
        self.questions = self.questionsCaretaker.retrieveQuestions()
        self.sequenceStrategy = .normal
        self.selectQuestionsStrategy = .all
    }
    
    func addGame(_ game: GameSession) {
        self.game = game
    }
    
    func selectStrategy(sequence: Sequence) {
        self.sequenceStrategy = sequence
    }
    
    func selectSelctQuestionsStrategy(order: SelectQuestions) {
        self.selectQuestionsStrategy = order
    }

    func clearGame() {
        self.game = nil
    }
    
    func incrementScore() {
        self.game?.score += 1
    }
    
    func usedHelp(help: MyHelps) {
        switch help {
        case .auditory:
            self.game?.isUsedAuditoryHelp = true
        case .halfQuestion:
            self.game?.isUsedHalfQuestionHelp = true
        case .callFriend:
            self.game?.isUsedCallFriendHelp = true
        }
    }
    
    func setupQuestionCount(questionCount: Int) {
        self.game?.questionCount = questionCount
    }
    
    func saveCustomQuestion(question: Question) {
        self.questions.append(question)
    }
    
    func saveAndFinishGame(username: String, percent: Double) {
        guard let games = game else { return }
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
