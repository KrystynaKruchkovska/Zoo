//
//  ImageCacheProtocol.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import UIKit

protocol ImageCacheProtocol {
    func setImage(_ image: UIImage, for url: URL)
    func getImage(for url: URL) -> UIImage?
}
