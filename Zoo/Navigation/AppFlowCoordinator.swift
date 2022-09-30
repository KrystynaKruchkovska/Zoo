//
//  AppFlowCoordinator.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

final class AppFlowCoordinator: FlowCoordinatorProtocol {
    
    let navigationController: UINavigationController
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private (set) var currentFlowCoordinator: FlowCoordinatorProtocol?
    
    private (set) var name: String = "App Flow Coordinator"

    func start(animated: Bool) {
        let coordinator = ZooListFlowCoordinator(navigationController: navigationController)
        currentFlowCoordinator = coordinator
        coordinator.start(animated: animated)
    }
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
}
