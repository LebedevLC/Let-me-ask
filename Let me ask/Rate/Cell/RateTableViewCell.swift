//
//  RateTableViewCell.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 03.12.2021.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    static let identifier = "RateTableViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        scoreLabel.text = nil
        dateLabel.text = nil
    }
    
    func config(model: RateModel) {
        nameLabel.text = model.name
        scoreLabel.text = "\(model.score) %"
        dateLabel.text = model.date
    }
}
