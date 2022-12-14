//
//  AnimalListViewModel.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import Combine
import Foundation

protocol AnimalListViewModelProtocol: AnyObject {
    func fetchAnimals()
    var animals: Animals { get }
    var fetchedAnimals: PassthroughSubject<Animals, Never> { get }
//    var imageDownloader: ImageDownloaderProtocol { get }

}

class AnimalListViewModel: AnimalListViewModelProtocol {
    private (set) var animals = [Animal]()
    private var cancellables = Set<AnyCancellable>()
    private (set) var fetchedAnimals = PassthroughSubject<Animals, Never>()
    private let networkingEngine: NetworkingEngineProtocol
    
    init(networkingEngine: NetworkingEngineProtocol) {
        self.networkingEngine = networkingEngine
    }
    var zooEndpoint: Endpoint = ZooEndpoint.getSearchResult(numberOfItems: 10)
    
    func fetchAnimals() {
        animals.removeAll()
        networkingEngine.request(endpoint: zooEndpoint,type: Animal.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
            receiveValue: { [weak self] animals in
                self?.animals = animals
                self?.fetchedAnimals.send(animals)
                print("Animals\(animals)")
            }
            .store(in: &cancellables)
    }
}
