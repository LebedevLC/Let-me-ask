//
//  SettingsVC.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 06.12.2021.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var sequenceQuestionSegmetControl: UISegmentedControl!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSegmentControl()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Game.shared.selectStrategy(sequence: sequenceQuestion)
    }
    
    private func setupSegmentControl() {
        let selected = Game.shared.sequence
        sequenceQuestionSegmetControl.selectedSegmentIndex = selected == .random ? 1 : 0
    }
}
