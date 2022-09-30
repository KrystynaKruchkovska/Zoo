//
//  File.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

class ZooListView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.addSubview(zooListTableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        zooListTableView.frame = self.bounds
    }
    
    var zooListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = 200
        tableView.backgroundColor = .white
        tableView.register(AnimalTableViewCell.self, forCellReuseIdentifier: AnimalTableViewCell.reusableIdentifier)
        return tableView
    }()
}
