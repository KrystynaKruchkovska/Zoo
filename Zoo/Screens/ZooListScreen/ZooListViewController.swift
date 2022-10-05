//
//  ZooListViewController.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit
import Combine

protocol ZooListViewControllerDelegate: AnyObject {
    
    func ZooListViewControllerDelegateDidSelect(_ zooListViewController: ZooListViewController, animal: Animal)
}


final class ZooListViewController: UIViewController {
    weak var delegate: ZooListViewControllerDelegate?

    private var viewModel: AnimalListViewModelProtocol
    private var imageDownloader: ImageDownloaderProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: AnimalListViewModelProtocol,
         imageDownloader: ImageDownloaderProtocol) {
        self.viewModel = viewModel
        self.imageDownloader = imageDownloader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var customView: ZooListView {
        return view as! ZooListView
    }
    
    override func loadView() {
        super.loadView()
        view = ZooListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        viewModel.fetchAnimals()
        observeFetchedAnimals()
    }
    
    private func observeFetchedAnimals() {
        viewModel.fetchedAnimals
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] animals in
                guard let self = self else {
                    return
                }
                self.customView.update(with: animals,
                                        imageDownloader: self.imageDownloader)
            }
            .store(in: &cancellables)
    }
}

extension ZooListViewController: ZooListViewDelegate {
       func onDidPullToRefreshData() {
           viewModel.fetchAnimals()
       }
}
