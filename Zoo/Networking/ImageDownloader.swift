//
//  ImageDownloader.swift
//  Zoo
//
//  Created by Paweł on 03/10/2022.
//

import UIKit
import Combine

final class ImageDownloader: ImageDownloaderProtocol {
    
    private var runningRequests = [UUID: URLSessionDataTask]()
    private let networkSession: NetworkingEngine
    private let imageCache: ImageCache
    private var cancelables = Set<AnyCancellable>()
    
    
    init(
        networkSession: NetworkingEngine,
        imageCache: ImageCache
    ) {
        self.networkSession = networkSession
        self.imageCache = imageCache
    }
    
    @discardableResult
    func download(with url: URL, completionHandler: @escaping (Result<UIImage, ImageDownloaderError>) -> Void) -> UUID? {
        if let image = imageCache.getImage(for: url) {
            completionHandler(.success(image))
            return nil
        }
        let uuid = UUID()
        
        networkSession.downloadTaskPublisher(with: url)
            .sink { completion in
            print("Completion\(completion)")
        } receiveValue: { image in
            print("Image\(String(describing: image))")
            guard let image = image else {
                return
            }
            self.imageCache.setImage(image, for: url)
        }.store(in: &cancelables)
        
        
        
//        let task = networkSession.dataTask(with: url) { data, response, error in
//            defer { self.runningRequests.removeValue(forKey: uuid) }
//            if let data = data, let image = UIImage(data: data) {
//                self.imageCache.setImage(image, for: url)
//                completionHandler(.success(image))
//                return
//            } else {
//                completionHandler(.failure(.failed))
//            }
//        }
//        task.resume()
//        runningRequests[uuid] = task
        return uuid
    }
    
    /// - SeeAlso: `ImageDownloader.cancelTask`
    func cancelTask(for UUID: UUID) {
        runningRequests[UUID]?.cancel()
        runningRequests.removeValue(forKey: UUID)
    }
}
