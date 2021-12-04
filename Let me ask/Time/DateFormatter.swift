//
//  DateFormatter.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 03.12.2021.
//

import Foundation

class DateFormatterRU {
    
    func ShowMeDate(date: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}
