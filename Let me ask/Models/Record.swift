//
//  Record.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 03.12.2021.
//

import Foundation

struct Record: Codable {
    let score: Int
    let questionCount: Int
    let percentWin: Double
    let username: String
    let date: Double
}
