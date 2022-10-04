//
//  ImageDownloaderProtocol.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import UIKit

protocol ImageDownloaderProtocol {
    func download(with url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    
    func cancelTask(for uuid: UUID)
}
