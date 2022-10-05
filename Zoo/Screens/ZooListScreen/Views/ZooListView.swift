//
//  File.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

class ZooListView: UIView {
    
    private var animals: Animals = []
    private var imageDownloader: ImageDownloaderProtocol?
//    let imageDownloader: ImageDownloaderProtocol

    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.imageDownloader = imageDownloader
        self.backgroundColor = .red
        self.addSubview(zooListTableView)
        setupTableView()
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
    
    private func setupTableView() {
        zooListTableView.dataSource = self
        zooListTableView.delegate = self
    }
    
    func update(with animals: Animals, imageDownloader: ImageDownloaderProtocol) {
        self.animals = animals
        self.imageDownloader = imageDownloader
        zooListTableView.reloadData()
    }
}

extension ZooListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimalTableViewCell.reusableIdentifier) as? AnimalTableViewCell else {
            return UITableViewCell()
        }
        let animal = animals[indexPath.row]
        cell.label.text = animal.name
        if let imgUrl =  URL(string: animal.imageLink) {
            cell.update(with: imgUrl, imageDownloader: imageDownloader)
//            zooListTableView.reloadData()
        }
        return cell
    }
}

extension ZooListView: UITableViewDelegate {
    
}
