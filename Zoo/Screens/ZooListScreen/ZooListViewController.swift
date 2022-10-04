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
    
    private var listView: ZooListView {
        return view as! ZooListView
    }
    private var viewModel: AnimalListViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: AnimalListViewModelProtocol) {
        self.viewModel = viewModel
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
        viewModel.fetchAnimals()
        observeFetchedAnimals()
    }
    
    private func observeFetchedAnimals() {
        viewModel.fetchedAnimals
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] animals in
                self?.customView.update(with: animals)
            }
            .store(in: &cancellables)
    }
    
}

