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
    
    @IBOutlet weak var saveButton: MyButton!
    @IBOutlet weak var clearButton: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
    }
    
}
