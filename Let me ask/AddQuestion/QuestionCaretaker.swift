//
//  QuestionCaretaker.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 07.12.2021.
//

import Foundation

protocol QuestionCaretakerProtocol {
    func saveQuestions(questions: [Question])
    func retrieveQuestions() -> [Question]
}

final class QuestionCaretaker: QuestionCaretakerProtocol {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let keyQuestions = "questions"
    
    func saveQuestions(questions: [Question]) {
        do {
            let data = try self.encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: keyQuestions)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: keyQuestions) else {
            return []
        }
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
}
