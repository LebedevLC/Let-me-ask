//
//  AddQuestionVC.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 07.12.2021.
//

import UIKit

class AddQuestionVC: UIViewController {

    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var rightAnswerTextField: UITextField!
    @IBOutlet weak var wrong1AnswerTextField: UITextField!
    @IBOutlet weak var wrong2AnswerTextField: UITextField!
    @IBOutlet weak var wrong3AnswerTextField: UITextField!
    
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrong1Label: UILabel!
    @IBOutlet weak var wrong2Label: UILabel!
    @IBOutlet weak var wrong3Label: UILabel!
    
    @IBOutlet weak var saveButton: MyButton!
    @IBOutlet weak var clearButton: MyButton!
    
    private var tapGesture: UITapGestureRecognizer?
    private var customQuestion: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMyTap()
        paintMyLabels()
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard
            let question = questionTextField.text,
            let rightAnswer = rightAnswerTextField.text,
            let wrongAnswer1 = wrong1AnswerTextField.text,
            let wrongAnswer2 = wrong2AnswerTextField.text,
            let wrongAnswer3 = wrong3AnswerTextField.text,
            question != "",
            rightAnswer != "",
            wrongAnswer1 != "",
            wrongAnswer2 != "",
            wrongAnswer3 != ""
        else {
            showAlert(isCorrect: false)
            return
        }
        customQuestion.append(.init(
            question: question,
            answerRight: rightAnswer,
            answer1: wrongAnswer1,
            answer2: wrongAnswer2,
            answer3: wrongAnswer3))
        clearTextFields()
        showAlert(isCorrect: true)
        debugPrint(customQuestion)
        guard let customQuestion = customQuestion.last else { return }
        Game.shared.saveCustomQuestion(question: customQuestion)
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        clearTextFields()
        debugPrint(Game.shared.questions)
    }
    
    private func clearTextFields() {
        questionTextField.text = nil
        rightAnswerTextField.text = nil
        wrong1AnswerTextField.text = nil
        wrong2AnswerTextField.text = nil
        wrong3AnswerTextField.text = nil
    }
    
    private func showAlert(isCorrect: Bool) {
        var myTitle = ""
        isCorrect ? (myTitle = "Данные успешно сохранены!") : (myTitle = "Пожалуйста, заполните все поля.")
        let alertController = UIAlertController(
            title: myTitle,
            message: "",
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel) { _ in
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: {})
    }
    
}

// MARK: - Keyboard

extension AddQuestionVC {
    
    private func setMyTap() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture!)
    }
    
    @objc private func hideKeyboard() {
        self.view?.endEditing(true)
    }
}

// MARK: - Painting Labels

extension AddQuestionVC {
    
    private func paintMyLabels() {
        let greenColor = UIColor(red: 0.165, green: 0.565, blue: 0.200, alpha: 1)

        let rightAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: greenColor]
        let wrongAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
        let blackAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]

        let firstString = NSMutableAttributedString(string: "Введите ", attributes: blackAttributes)
        let secondString = NSMutableAttributedString(string: "Введите ", attributes: blackAttributes)
        let rightWord = NSAttributedString(string: "верный ", attributes: rightAttributes)
        let wrongWord = NSAttributedString(string: "неверный ", attributes: wrongAttributes)
        let thirdWord = NSAttributedString(string: "ответ", attributes: blackAttributes)

        firstString.append(rightWord)
        firstString.append(thirdWord)
        
        secondString.append(wrongWord)
        secondString.append(thirdWord)
        
        rightLabel.attributedText = firstString
        wrong1Label.attributedText = secondString
        wrong2Label.attributedText = secondString
        wrong3Label.attributedText = secondString
    }
}
