//
//  AppFlowCoordinator.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

final class AppFlowCoordinator: FlowCoordinatorProtocol {

    var rootViewController: UIViewController {
        return navigationController
    }
    private (set) var navigationController: UINavigationController
    private (set) unowned var dependencyProvider: DependencyProvider
    private (set) var currentFlowCoordinator: FlowCoordinatorProtocol?
    private (set) var name: String = "App Flow Coordinator"

    func start(animated: Bool) {
        let coordinator = ZooListFlowCoordinator(dependencyProvider: dependencyProvider, navigationController: navigationController)
        currentFlowCoordinator = coordinator
        coordinator.start(animated: animated)
    }
    
    init(navigationController: UINavigationController = UINavigationController(),
         dependencyProvider: DependencyProvider) {
        self.navigationController = navigationController
        self.dependencyProvider = dependencyProvider
    }
}
