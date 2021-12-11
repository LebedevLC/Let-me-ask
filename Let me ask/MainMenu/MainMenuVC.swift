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
    @IBOutlet weak var addQuestionButton: UIButton!
    
    private var tapGesture: UITapGestureRecognizer?
    
    private var sequenceQuestionStrategy: SequenceQuestionStrategy {
        switch Game.shared.sequenceStrategy {
        case .normal:
            return SequenceQuestionNormalStrategy()
        case .random:
            return SequenceQuestionRandomStrategy()
        }
    }
    
    private var selectQuestionsStrategy: SelectQuestionsStrategy {
        switch Game.shared.selectQuestionsStrategy {
        case .all:
            return SelectQuestionsAllStrategy()
        case .system:
            return SelectQuestionsSystemStrategy()
        case .custom:
            return SelectQuestionsCustomStrategy()
        }
    }
    
// MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMyTap()
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
    
    // MARK: - Segue
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRate", sender: nil)
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSettings", sender: nil)
    }
    
    func letsGo(name: String) {
        let game: GameSession
        game = GameSession(
            score: 0,
            questionCount: 0,
            username: name,
            isUsedAuditoryHelp: false,
            isUsedHalfQuestionHelp: false,
            isUsedCallFriendHelp: false)
        Game.shared.addGame(game)
        performSegue(withIdentifier: "goToGame", sender: nil)
    }
    
    @IBAction func addQuestionButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAddQuestion", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToGame":
            let destinationVC = segue.destination as? GameVC
            destinationVC?.sequenceQuestionStrategy = self.sequenceQuestionStrategy
            destinationVC?.selectQuestionsStategy = self.selectQuestionsStrategy
        case "goToRate":
            break
        case "goToSettings":
            break
        case "goToAddQuestion":
            break
        default:
            break
        }
    }
}

// MARK: - Alert

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
            self.letsGo(name: "Мыслитель")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: {})
    }
}

// MARK: - Keyboard

extension MainMenuVC {
    
    private func setMyTap() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture!)
    }
    
    @objc private func hideKeyboard() {
        self.view?.endEditing(true)
    }
}

