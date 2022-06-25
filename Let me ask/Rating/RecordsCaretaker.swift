//
//  RecordsCaretaker.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 03.12.2021.
//

import Foundation

protocol RecordsCaretakerProtocol {
    func saveRecords(records: [Record])
    func retrieveRecords() -> [Record]
}

final class RecordsCaretaker: RecordsCaretakerProtocol {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let keyRecords = "records"
    
    func saveRecords(records: [Record]) {
        do {
            let data = try self.encoder.encode(records)
            UserDefaults.standard.set(data, forKey: keyRecords)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func retrieveRecords() -> [Record] {
        guard let data = UserDefaults.standard.data(forKey: keyRecords) else {
            return []
        }
        do {
            return try self.decoder.decode([Record].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
}
