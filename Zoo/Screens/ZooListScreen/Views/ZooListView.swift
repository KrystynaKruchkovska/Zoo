//
//  File.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

protocol ZooListViewDelegate: AnyObject {
    func onDidPullToRefreshData()
}

class ZooListView: UIView {
    private var animals: Animals = []
    private var imageDownloader: ImageDownloaderProtocol?
    weak var delegate: ZooListViewDelegate? = nil
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
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .green
        return tableView
    }()
    
    private func setupTableView() {
        zooListTableView.dataSource = self
        zooListTableView.delegate = self
        zooListTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    func update(with animals: Animals, imageDownloader: ImageDownloaderProtocol) {
        self.animals = animals
        self.imageDownloader = imageDownloader
        if zooListTableView.refreshControl?.isRefreshing == true {
            zooListTableView.refreshControl?.endRefreshing()
        }
        zooListTableView.reloadData()
    }
    
    @objc func didPullToRefresh() {
        delegate?.onDidPullToRefreshData()
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
        }
        return cell
    }
}

extension ZooListView: UITableViewDelegate {

}
