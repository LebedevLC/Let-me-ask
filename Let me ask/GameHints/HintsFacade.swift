//
//  HintsFacade.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 12.12.2021 00:50
//

import UIKit

final class HintsFacade {
    
    weak var gameVC: GameVC?

    init(gameVC: GameVC) {
        self.gameVC = gameVC
    }
    
    // MARK: - Логика подсказок
    
    /// Помощь зала
    /// - Parameter buttons: Массив кнопок
    func auditoryAlert(buttons: [UIButton]) {
        let answerRightPercent = Int.random(in: 0...60)
        let answerWrong1Percent = Int.random(in: 0..<(100 - answerRightPercent))
        let answerWrong2Percent = Int.random(in: 0..<(100 - (answerRightPercent + answerWrong1Percent)))
        let answerWrong3Percent = 100 - (answerWrong2Percent + answerWrong1Percent + answerRightPercent)
        let buttonsTitle = buttons.map{$0.titleLabel?.text ?? ""}
        let alertController = UIAlertController(
            title: "Аудитория пришла к таким выводам: ",
            message: """
            \(buttonsTitle[0]) = \(answerRightPercent)%
            \(buttonsTitle[1]) = \(answerWrong1Percent)%
            \(buttonsTitle[2]) = \(answerWrong2Percent)%
            \(buttonsTitle[3]) = \(answerWrong3Percent)%
            """,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .destructive) { _ in
        }
        alertController.addAction(cancelAction)
        gameVC?.present(alertController, animated: true, completion: {})
    }
    
    /// Убрать два неверных ответа
    /// - Parameters:
    ///   - buttons: Массив кнопок
    ///   - selectQuestion: Текущий вопрос
    func halfQuestionHide(buttons: [UIButton], selectQuestion: Question) {
        var wrongButtons = buttons.filter{$0.titleLabel?.text != selectQuestion.answerRight}
        wrongButtons.remove(at: Int.random(in: 0...2))
        let _ = wrongButtons.map{$0.isEnabled = false}
        gameVC?.isDisableHalfButtons = true
    }
    
    /// Звонок другу
    /// - Parameter selectQuestion: Текущий вопрос
    func callToFriend(selectQuestion: Question) {
        let answers = [
            // для увеличения вероятности правильного ответа
            // добавляю несколько элеметнов правильного ответа
            selectQuestion.answerRight,
            selectQuestion.answerRight,
            selectQuestion.answerRight,
            selectQuestion.answerRight,
            selectQuestion.answer1,
            selectQuestion.answer2,
            selectQuestion.answer3
        ]
        let friendAnsweer = answers[Int.random(in: 0..<answers.count)]
        let alertController = UIAlertController(
            title: "Друг из паралельной вселенной \(Game.shared.game!.username), говорит: ",
            message: """
            Я думаю, что правильный ответ
            \(friendAnsweer)
            """,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .destructive) { _ in
        }
        alertController.addAction(cancelAction)
        gameVC?.present(alertController, animated: true, completion: {})
    }
    
}
