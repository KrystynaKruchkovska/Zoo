//
//  ImageDownloader.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import UIKit
import Combine

class ImageDownloader: ImageDownloaderProtocol {
    
    private var runningRequests = [UUID: URLSessionDataTask]()
    private let networkingEngine: NetworkingEngineProtocol
    private let imageCache: ImageCacheProtocol
    private var cancellables = Set<AnyCancellable>()
    private (set) var fetchedImage = PassthroughSubject<UIImage, Never>()

    init(networkingEngine: NetworkingEngineProtocol,
        imageCache: ImageCacheProtocol) {
        self.networkingEngine = networkingEngine
        self.imageCache = imageCache
    }
    
    func download(with url: URL) -> UUID? {
        if let image = imageCache.getImage(for: url) {
            self.fetchedImage.send(image)
          return nil
        }
        let uuid = UUID()
            networkingEngine.downloadTaskPublisher(with: url)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure(let err):
                        print("Error is \(err.localizedDescription)")
                    case .finished:
                        print("Finished")
                    }
                }
                receiveValue: { [weak self] image in
                    guard let image = image else {
                        return
                    }
                    self?.fetchedImage.send(image)
                    print("Image\(String(describing: image))")
                }
                .store(in: &cancellables)
        return uuid
    }
    
    func cancelTask(for uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
    
}
extension ImageDownloader {
    var num: String {
        return ""
    }
}
