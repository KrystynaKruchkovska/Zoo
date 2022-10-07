//
//  ImageDownloaderProtocol.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import UIKit
import Combine

protocol ImageDownloaderProtocol {

    func download(with url: URL) -> Future<UIImage, Error>
    func cancelTask(for uuid: UUID)
}
