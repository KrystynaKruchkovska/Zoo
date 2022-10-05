//
//  ZooListFlowCoordinator.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

final class ZooListFlowCoordinator: FlowCoordinatorProtocol {
    
    let navigationController: UINavigationController
    var rootViewController: UIViewController
    
    private (set) var dependencyProvider: DependencyProvider

    private (set) var currentFlowCoordinator: FlowCoordinatorProtocol?
    
    private (set) var name: String = "Zoo List Flow Coordinator"
    
    func start(animated: Bool) {
        navigationController.navigationBar.barTintColor = .green
        navigationController.navigationBar.tintColor = .cyan
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.backgroundColor: UIColor.cyan]
        
        showZooListVC()
    }
    
    init(currentFlowCoordinator: FlowCoordinatorProtocol? = nil,
         dependencyProvider: DependencyProvider,
         navigationController: UINavigationController) {
        self.rootViewController = navigationController
        self.currentFlowCoordinator = currentFlowCoordinator
        self.dependencyProvider = dependencyProvider
        self.navigationController = navigationController
    }
}


private extension ZooListFlowCoordinator {
    func showZooListVC(animated: Bool = true) {
        let viewModel = AnimalListViewModel(networkingEngine: dependencyProvider.networkingEngine)
        let zooListVC = ZooListViewController(viewModel: viewModel, imageDownloader: dependencyProvider.imageDownloader)
//        viewController.delegate = self

        navigationController.setViewControllers([zooListVC], animated: animated)
    }
}
