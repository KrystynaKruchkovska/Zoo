//
//  ImageDownloader.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import UIKit

class ImageDownloader: ImageDownloaderProtocol {
    
    private var runningRequests = [UUID: URLSessionDataTask]()
    private let networkingEngine: NetworkingEngineProtocol
    private let imageCache: ImageCacheProtocol
    
    init(networkingEngine: NetworkingEngineProtocol,
        imageCache: ImageCacheProtocol) {
        self.networkingEngine = networkingEngine
        self.imageCache = imageCache
    }
    func download(with url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = imageCache.getImage(for: url) {
           completionHandler(.success(image))
          return nil
        }
        let uuid = UUID()
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
    
    func cancelTask(for uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
    
}
