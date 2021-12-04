//
//  GameVC.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 30.11.2021.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    private var allQuestion: [Question] = []
    private var selectQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allQuestion = QuestionStorage().questions
        randomQuestion()
        beganGame()
    }
    
    // MARK: - Кнопки
    
    @IBAction func helpButtonTapped(_ sender: UIButton) {
        nextQuestion()
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
        Game.shared.setupQuestionCount(questionCount: allQuestion.count)
    }
    
    /// Получить случайный вопрос
    private func randomQuestion() {
        let rand = Int.random(in: 0..<allQuestion.count)
        selectQuestion = rand
        presentQuestion(questionNumber: rand)
    }
    
    /// Получить следующий вопрос (без конца)
    private func nextQuestion() {
        if  selectQuestion + 1 >= allQuestion.count {
            selectQuestion = 0
        } else {
            selectQuestion = selectQuestion + 1
        }
        presentQuestion(questionNumber: selectQuestion)
    }
    
    /// Отобразить вопрос
    private func presentQuestion(questionNumber: Int) {
        let randRightAnswer = Int.random(in: 0..<4)
        var buttons = [answer1Button, answer2Button, answer3Button, answer4Button]
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
            let score = Game.shared.games?.score,
            score >= allQuestion.count
        else {
            nextQuestion()
            return
        }
        showAlert(isWin: true)
    }
    
    /// Конец игры
    private func finishGame() {
        showAlert(isWin: false)
    }
    
    /// Алерт для окончания игры
    private func showAlert(isWin: Bool) {
        var myTitle = ""
        isWin ? (myTitle = "Вы выиграли! Ура!") : (myTitle = "Вы проиграли!")
        guard
            allQuestion.count != 0,
            let localScore = Game.shared.games?.score
        else { return }
        let percentWin = ((Double(localScore) / Double(allQuestion.count)) * 100).rounded()
        let alertController = UIAlertController(
            title: myTitle,
            message: """
            Колличество правильных ответов = \(localScore)
            Колличество вопросов = \(allQuestion.count)
            Процент верных ответов = \(percentWin) %
            """,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .destructive) { _ in
            Game.shared.finishGame(username: "test", percent: percentWin)
            self.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: {})
    }
}