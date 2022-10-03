//
//  ImageDownloader.swift
//  Zoo
//
//  Created by Paweł on 03/10/2022.
//

import UIKit

enum ImageDownloaderError: Error {
    case failed
}

protocol ImageDownloaderProtocol: AnyObject {
    @discardableResult
    func download(with url: URL, completionHandler: @escaping (Result<UIImage, ImageDownloaderError>) -> Void) -> UUID?

    func cancelTask(for UUID: UUID)
}
