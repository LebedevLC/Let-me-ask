//
//  GameCaretaker.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 03.12.2021.
//

import Foundation

// 2. Memento
typealias Memento = Data

// 3. Caretaker
protocol GameCaretakerProtocol {
    func save(records: [Record])
    func retrieveRecords() -> [Record]
}

final class GameCaretaker: GameCaretakerProtocol {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "records"

    func save(records: [Record]) {
        do {
            let data = try self.encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func retrieveRecords() -> [Record] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Record].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
