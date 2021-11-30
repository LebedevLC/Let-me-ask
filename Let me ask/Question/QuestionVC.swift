//
//  QuestionVC.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 30.11.2021.
//

import UIKit

class QuestionVC: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    var allQuestion: [Question] = []
    var selectQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allQuestion = QuestionStorage().questions
        randomQuestion()
    }
    
    @IBAction func helpButtonTapped(_ sender: UIButton) {
        nextQuestion()
    }
    
    @IBAction func answer1ButtonTapped(_ sender: UIButton) {
        print("tap 1")
        if answer1Button.titleLabel?.text == allQuestion[selectQuestion].answerRight {
            print("Win")
            nextQuestion()
        }
    }
    
    @IBAction func answer2ButtonTapped(_ sender: UIButton) {
        print("tap 2")
        if answer2Button.titleLabel?.text == allQuestion[selectQuestion].answerRight {
            print("Win")
            nextQuestion()
        }
    }
    
    @IBAction func answer3ButtonTapped(_ sender: UIButton) {
        print("tap 3")
        if answer3Button.titleLabel?.text == allQuestion[selectQuestion].answerRight {
            print("Win")
            nextQuestion()
        }
    }
    
    @IBAction func answe4ButtonTapped(_ sender: UIButton) {
        print("tap 4")
        if answer4Button.titleLabel?.text == allQuestion[selectQuestion].answerRight {
            print("Win")
            nextQuestion()
        }
    }
    
    func randomQuestion() {
        let rand = Int.random(in: 0..<allQuestion.count)
        selectQuestion = rand
        presentQuestion(questionNumber: rand)
    }
    
    func nextQuestion() {
        if  selectQuestion + 1 >= allQuestion.count {
            selectQuestion = 0
        } else {
            selectQuestion = selectQuestion + 1
        }
        presentQuestion(questionNumber: selectQuestion)
    }
    
    func presentQuestion(questionNumber: Int) {
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
    
}
