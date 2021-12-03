//
//  MainMenuVC.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 30.11.2021.
//

import UIKit

class MainMenuVC: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var rateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }

    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        let game = GameSession(score: 0, questionCount: 0)
        Game.shared.addGame(game)
        performSegue(withIdentifier: "goToGame", sender: nil)
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRate", sender: nil)
    }
}

extension MainMenuVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            newGameButton.isUserInteractionEnabled = true
    }
}

