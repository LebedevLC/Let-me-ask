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
        nameTextField.delegate = self
        super.viewDidLoad()
    }

    @IBAction func newGameButtonTapped(_ sender: UIButton) {
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

