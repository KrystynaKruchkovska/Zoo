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

    init(networkingEngine: NetworkingEngineProtocol,
        imageCache: ImageCacheProtocol) {
        self.networkingEngine = networkingEngine
        self.imageCache = imageCache
    }
    
    func download(with url: URL) -> Future<UIImage, Never> {
        Future { [weak self] promise in
            if let image = self?.imageCache.getImage(for: url) {
                return promise(.success(image))
            }
            self?.networkingEngine.dataTaskPublisher(with: url)
                .receive(on: RunLoop.main)
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
            self?.imageCache.setImage(image, for: url)
            print("Image\(String(describing: image))")
            return promise(.success(image))
        }
        .store(in: &self!.cancellables)
        }
    }
    
    func cancelTask(for uuid: UUID) {
//        runningRequests[uuid]?.cancel()
//        runningRequests.removeValue(forKey: uuid)
    }
    
    
    
}
extension ImageDownloader {
    var num: String {
        return ""
    }
}
