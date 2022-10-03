//
//  ImageCache.swift
//  Zoo
//
//  Created by Paweł on 03/10/2022.
//

import UIKit

protocol ImageCache: AnyObject {
    func setImage(_ image: UIImage, for URL: URL)
    func getImage(for URL: URL) -> UIImage?
}
