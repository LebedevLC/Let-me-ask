//
//  GameVC.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 30.11.2021.
//

import UIKit

final class GameVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var auditoryHelpButton: UIButton!
    @IBOutlet weak var callFriendHelpButton: UIButton!
    @IBOutlet weak var halfQuestionHelpButton: UIButton!
    
    private var allQuestion: [Question] = []
    private var selectQuestion = -1 {
        didSet {
            self.observableSelectQuestion.value += 1
        }
    }
    private var isDisableHalfButtons = false
    private var observableSelectQuestion = Observable<Int>(0)
    
    var sequenceQuestionStrategy: SequenceQuestionStrategy?
    var selectQuestionsStategy: SelectQuestionsStrategy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allQuestion = selectQuestionsStategy!.giveMeQuestions()
        nextQuestion()
        beganGame()
    }
    
    // MARK: - Кнопки
    
    @IBAction func auditoryHelpButtonTapped(_ sender: UIButton) {
        auditoryAlert()
        Game.shared.usedHelp(help: .auditory)
        auditoryHelpButton.isEnabled = false
    }
    
    @IBAction func halfQuestionButtonTapped(_ sender: UIButton) {
        halfQuestionHide()
        Game.shared.usedHelp(help: .halfQuestion)
        halfQuestionHelpButton.isEnabled = false
    }
    
    @IBAction func callFriendButtonTapped(_ sender: UIButton) {
        callToFriend()
        Game.shared.usedHelp(help: .callFriend)
        callFriendHelpButton.isEnabled = false
    }
    
    @IBAction func answer1ButtonTapped(_ sender: UIButton) {
        answer1Button.titleLabel?.text == allQuestion[selectQuestion].answerRight ? rightAnswer() : finishGame()
    }
    
    @IBAction func answer2ButtonTapped(_ sender: UIButton) {
        answer2Button.titleLabel?.text == allQuestion[selectQuestion].answerRight ? rightAnswer() : finishGame()
    }
    
    @IBAction func answer3ButtonTapped(_ sender: UIButton) {
        answer3Button.titleLabel?.text == allQuestion[selectQuestion].answerRight ? rightAnswer() : finishGame()
    }
    
    @IBAction func answe4ButtonTapped(_ sender: UIButton) {
        answer4Button.titleLabel?.text == allQuestion[selectQuestion].answerRight ? rightAnswer() : finishGame()
    }
    
    // MARK: - Логика
    
    /// Начало игры
    private func beganGame() {
        let allQuestionCount = allQuestion.count
        Game.shared.setupQuestionCount(questionCount: allQuestionCount)
        
        // Добавляем наблюдателя
        observableSelectQuestion.addObserver(
            self,
            options: [.new, .initial],
            closure: { [weak self] (selectQuestion, _) in
                guard let self = self else { return }
                self.statusLabel.text = "Вопрос \(selectQuestion) из \(allQuestionCount)"
            })
    }
    
    /// Реализация стратегии
    private func nextQuestion() {
        let nextSelectQuestion = sequenceQuestionStrategy!.nextQuestion(
            selectQuestion: self.selectQuestion,
            count: allQuestion.count)
        if nextSelectQuestion >= 0 {
            selectQuestion = nextSelectQuestion
            presentQuestion(questionNumber: nextSelectQuestion)
        } else {
            showAlert(isWin: true)
        }
    }
    
    /// Отобразить вопрос
    private func presentQuestion(questionNumber: Int) {
        let randRightAnswer = Int.random(in: 0..<4)
        var buttons = [answer1Button, answer2Button, answer3Button, answer4Button]
        if isDisableHalfButtons {
            let _ = buttons.map{$0?.isEnabled = true}
            isDisableHalfButtons.toggle()
        }
        let answer = [allQuestion[questionNumber].answer1, allQuestion[questionNumber].answer2, allQuestion[questionNumber].answer3]
        
        questionLabel.text = allQuestion[questionNumber].question
        
        buttons[randRightAnswer]?.setTitle(allQuestion[questionNumber].answerRight, for: .normal)
        buttons.remove(at: randRightAnswer)
        
        for i in 0..<buttons.count {
            buttons[i]?.setTitle(answer[i], for: .normal)
        }
    }
    
    /// Правильный ответ
    private func rightAnswer() {
        Game.shared.incrementScore()
        guard
            let score = Game.shared.game?.score,
            score >= allQuestion.count
        else {
            nextQuestion()
            return
        }
        showAlert(isWin: true)
    }
    
    /// Конец игры (проигрыш)
    private func finishGame() {
        showAlert(isWin: false)
    }
    
    /// Алерт для окончания игры
    private func showAlert(isWin: Bool) {
        var myTitle = ""
        isWin ? (myTitle = "Вы выиграли! Ура!") : (myTitle = "Вы проиграли!")
        guard
            allQuestion.count != 0,
            let localScore = Game.shared.game
        else { return }
        let percentWin = ((Double(localScore.score) / Double(allQuestion.count)) * 100).rounded()
        let alertController = UIAlertController(
            title: myTitle,
            message: """
            Колличество правильных ответов = \(localScore.score)
            Колличество вопросов = \(allQuestion.count)
            Процент верных ответов = \(percentWin) %
            """,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .destructive) { _ in
            Game.shared.saveAndFinishGame(username: localScore.username, percent: percentWin)
            self.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: {})
    }
}

// MARK: - Логика подсказок

extension GameVC {
    
    private func auditoryAlert() {
        let answerRightPercent = Int.random(in: 0...60)
        let answerWrong1Percent = Int.random(in: 0..<(100 - answerRightPercent))
        let answerWrong2Percent = Int.random(in: 0..<(100 - (answerRightPercent + answerWrong1Percent)))
        let answerWrong3Percent = 100 - (answerWrong2Percent + answerWrong1Percent + answerRightPercent)
        let buttonsTitle = [
            answer1Button.titleLabel?.text ?? "",
            answer2Button.titleLabel?.text ?? "",
            answer3Button.titleLabel?.text ?? "",
            answer4Button.titleLabel?.text ?? ""
        ]
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
        present(alertController, animated: true, completion: {})
    }
}

extension GameVC {
    
    private func halfQuestionHide() {
        let buttons = [answer1Button, answer2Button, answer3Button, answer4Button]
        var wrongButtons = buttons.filter{$0?.titleLabel?.text != allQuestion[selectQuestion].answerRight}
        wrongButtons.remove(at: Int.random(in: 0...2))
        let _ = wrongButtons.map{$0?.isEnabled = false}
        isDisableHalfButtons = true
    }
}

extension GameVC {
    
    private func callToFriend() {
        let answers = [
            allQuestion[selectQuestion].answerRight,
            // для увеличения вероятности правильного ответа
            // добавляю несколько элеметнов правильного ответа
            allQuestion[selectQuestion].answerRight,
            allQuestion[selectQuestion].answerRight,
            allQuestion[selectQuestion].answerRight,
            allQuestion[selectQuestion].answer1,
            allQuestion[selectQuestion].answer2,
            allQuestion[selectQuestion].answer3]
        let friendAnsweer = answers[Int.random(in: 0..<answers.count)]
        let alertController = UIAlertController(
            title: "Друг из паралельной вселенной \(Game.shared.game!.username) говорит: ",
            message: """
            Я думаю, что правильный ответ
            \(friendAnsweer)
            """,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .destructive) { _ in
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: {})
    }
}
