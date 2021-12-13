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
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = Game.shared.score.last?.username ?? ""
    }

    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        guard
            let name = nameTextField.text,
                !name.isEmpty
        else {
            showAlert()
            return }
        letsGo(name: name)
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRate", sender: nil)
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSettings", sender: nil)
    }
    
    func letsGo(name: String) {
        let game: GameSession
        game = GameSession(score: 0, questionCount: 0, username: name)
        Game.shared.addGame(game)
        performSegue(withIdentifier: "goToGame", sender: nil)
    }
    
    
}

extension MainMenuVC {
    private func showAlert() {
        let myTitle = "Вы забыли указать имя!"
        let alertController = UIAlertController(
            title: myTitle,
            message: """
            Пожалуйста, укажите своё имя.
            (Или оставьте стандартное)
            """,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Изменить", style: .cancel) { _ in
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Оставить стандартное", style: .default) { _ in
            self.letsGo(name: "Загадочный мыслитель")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: {})
    }
}


