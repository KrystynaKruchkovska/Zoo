//
//  ImageDownloaderProtocol.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import UIKit
import Combine

protocol ImageDownloaderProtocol {
    var fetchedImage: PassthroughSubject<UIImage, Never> { get }

//    func download(with url: URL) -> UUID?
    func download(with url: URL) -> Future<UIImage, Never>
    func cancelTask(for uuid: UUID)
}
