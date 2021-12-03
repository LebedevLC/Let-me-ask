//
//  RateVC.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 30.11.2021.
//

import UIKit

struct RateModel {
    let name: String
    let score: Double
    let date: String
}

class RateVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let records = Game.shared.score
    private let dateFormatterRU = DateFormatterRU()
    private var rateModel: [RateModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        setupTable()
    }
    
    func setupModel() {
        for i in 0..<records.count {
            let date = dateFormatterRU.ShowMeDate(date: self.records[i].date)
            rateModel.append(.init(
                name: self.records[i].username,
                score: self.records[i].percentWin,
                date: date)
            )
        }
        rateModel.sort{$0.date > $1.date}
    }
}

extension RateVC: UITableViewDataSource, UITableViewDelegate {
    func setupTable() {
        tableView.register(UINib(nibName: RateTableViewCell.identifier,
                                 bundle: nil), forCellReuseIdentifier: RateTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rateModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RateTableViewCell.identifier,
                                                       for: indexPath) as? RateTableViewCell
        else {
            return UITableViewCell()
        }
        let cellModel = rateModel[indexPath.row]
        cell.config(model: cellModel)
        return cell
    }
}
