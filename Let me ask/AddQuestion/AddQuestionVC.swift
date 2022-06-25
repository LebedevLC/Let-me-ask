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
        guard checkTextFields() else {
            showAlert(isCorrect: false)
            return
        }
        customQuestion.append(buildQuestion())
        clearTextFields()
        showAlert(isCorrect: true)
        guard let customQuestion = customQuestion.last else { return }
        Game.shared.saveCustomQuestion(question: customQuestion)
        
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        clearTextFields()
        debugPrint(Game.shared.questions)
    }
    
    private func checkTextFields() -> Bool {
        if
            questionTextField.text != "",
            rightAnswerTextField.text != "",
            wrong1AnswerTextField.text != "",
            wrong2AnswerTextField.text != "",
            wrong3AnswerTextField.text != ""
        {
            return true
        } else { return false }
    }
    
    private func buildQuestion() -> Question {
        let builder = NewQuestionBuilder()
        builder.setQuestion(questionTextField.text!)
        builder.setanswerRight(rightAnswerTextField.text!)
        builder.setAnswer1(wrong1AnswerTextField.text!)
        builder.setAnswer2(wrong2AnswerTextField.text!)
        builder.setAnswer3(wrong3AnswerTextField.text!)
        return builder.build()
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
        let rightAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.customGreen]
        let wrongAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
        let blackAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]

        let rightString = NSMutableAttributedString(string: "Введите ", attributes: blackAttributes)
        let wrongString = NSMutableAttributedString(string: "Введите ", attributes: blackAttributes)
        let rightWord = NSAttributedString(string: "верный ", attributes: rightAttributes)
        let wrongWord = NSAttributedString(string: "неверный ", attributes: wrongAttributes)
        let thirdWord = NSAttributedString(string: "ответ", attributes: blackAttributes)

        rightString.append(rightWord)
        rightString.append(thirdWord)
        
        wrongString.append(wrongWord)
        wrongString.append(thirdWord)
        
        rightLabel.attributedText = rightString
        wrong1Label.attributedText = wrongString
        wrong2Label.attributedText = wrongString
        wrong3Label.attributedText = wrongString
    }
}
