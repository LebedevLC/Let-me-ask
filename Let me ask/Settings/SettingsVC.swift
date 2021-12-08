//
//  SettingsVC.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 06.12.2021.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var sequenceQuestionSegmetControl: UISegmentedControl!
    @IBOutlet weak var selectQuestionsSegmentControl: UISegmentedControl!
    
    private var sequenceQuestion: Sequence {
        switch sequenceQuestionSegmetControl.selectedSegmentIndex {
        case 0:
            return .normal
        case 1:
            return .random
        default:
            return .normal
        }
    }
    
    private var selectQuestions: SelectQuestions {
        switch selectQuestionsSegmentControl.selectedSegmentIndex {
        case 0:
            return .all
        case 1:
            return .system
        case 2:
            return .custom
        default:
            return .all
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSegmentControls()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Game.shared.selectStrategy(sequence: sequenceQuestion)
        Game.shared.selectSelctQuestionsStrategy(order: selectQuestions)
    }
    
    private func setupSegmentControls() {
        let sequence = Game.shared.sequenceStrategy
        sequenceQuestionSegmetControl.selectedSegmentIndex = sequence == .random ? 1 : 0
        
        switch Game.shared.selectQuestionsStrategy {
        case .all:
            selectQuestionsSegmentControl.selectedSegmentIndex = 0
        case .system:
            selectQuestionsSegmentControl.selectedSegmentIndex = 1
        case .custom:
            selectQuestionsSegmentControl.selectedSegmentIndex = 2
        }
    }
    
}
