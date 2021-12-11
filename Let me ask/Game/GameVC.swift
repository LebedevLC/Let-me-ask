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
    private var observableSelectQuestion = Observable<Int>(0)
    
    var hintsFacade: HintsFacade?
    var sequenceQuestionStrategy: SequenceQuestionStrategy?
    var selectQuestionsStategy: SelectQuestionsStrategy?
    
    var buttons: [UIButton] = []
    var isDisableHalfButtons = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allQuestion = selectQuestionsStategy!.giveMeQuestions()
        nextQuestion()
        beganGame()
    }
    
    // MARK: - Кнопки подсказок
    
    @IBAction func auditoryHelpButtonTapped(_ sender: UIButton) {
        self.hintsFacade?.auditoryAlert(buttons: self.buttons)
        auditoryHelpButton.isEnabled = false
    }
    
    @IBAction func halfQuestionButtonTapped(_ sender: UIButton) {
        self.hintsFacade?.halfQuestionHide(buttons: self.buttons, selectQuestion: allQuestion[selectQuestion])
        halfQuestionHelpButton.isEnabled = false
    }
    
    @IBAction func callFriendButtonTapped(_ sender: UIButton) {
        self.hintsFacade?.callToFriend(selectQuestion: allQuestion[selectQuestion])
        callFriendHelpButton.isEnabled = false
    }
    
    // MARK: - Кнопки ответов
    
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
        buttons = [answer1Button, answer2Button, answer3Button, answer4Button]
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
    /// - Parameter questionNumber: Индекс текущего вопроса в массиве вопросов
    private func presentQuestion(questionNumber: Int) {
        let randRightAnswer = Int.random(in: 0..<4)
        var buttons = self.buttons
        if isDisableHalfButtons {
            let _ = buttons.map{$0.isEnabled = true}
            isDisableHalfButtons.toggle()
        }
        let selectAnswer = allQuestion[questionNumber]
        let answers = [selectAnswer.answer1, selectAnswer.answer2, selectAnswer.answer3]

        questionLabel.text = selectAnswer.question
        buttons[randRightAnswer].setTitle(selectAnswer.answerRight, for: .normal)
        buttons.remove(at: randRightAnswer)
        for i in 0..<buttons.count {
            buttons[i].setTitle(answers[i], for: .normal)
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
    /// - Parameter isWin: Победа или поражение
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
