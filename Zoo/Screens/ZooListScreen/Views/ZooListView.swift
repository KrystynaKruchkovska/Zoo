//
//  File.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

class ZooListView: UIView {
    private var animals: Animals = []
    let imageDownloader: ImageDownloaderProtocol

    init(imageDownloader: ImageDownloaderProtocol) {
        self.imageDownloader = imageDownloader
        super.init(frame: .zero)
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
    
    private func setupTableView() {
        zooListTableView.dataSource = self
        zooListTableView.delegate = self
    }
    
    var zooListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = 200
        tableView.backgroundColor = .white
        tableView.register(AnimalTableViewCell.self, forCellReuseIdentifier: AnimalTableViewCell.reusableIdentifier)
        return tableView
    }()
    
    func update(with animals: Animals) {
        self.animals = animals
        zooListTableView.reloadData()
    }
 
}

extension ZooListView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimalTableViewCell.reusableIdentifier) as! AnimalTableViewCell
        let animal = animals[indexPath.row]
        cell.label.text = animal.name
        if let imgUrl =  URL(string: animal.imageLink) {
            cell.update(with: imgUrl, imageDownloader: imageDownloader)
        }
        return cell
    }
    
}

extension ZooListView: UITableViewDelegate {
    
}
