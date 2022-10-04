//
//  AppFlowCoordinatorProtocol.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

protocol FlowCoordinatorProtocol: AnyObject {
    
    var rootViewController: UIViewController { get }
    var dependencyProvider: DependencyProvider { get }
    var currentFlowCoordinator: FlowCoordinatorProtocol? { get }

    var name: String { get }
    
    func start(animated: Bool)
    
}
