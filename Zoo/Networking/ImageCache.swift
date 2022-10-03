//
//  ImageCache.swift
//  Zoo
//
//  Created by Paweł on 03/10/2022.
//

import UIKit

final class DefaultImageCache: ImageCache {

    private let cache = NSCache<NSURL, UIImage>()

    func setImage(_ image: UIImage, for URL: URL) {
        cache.setObject(image, forKey: URL as NSURL)
    }

    func getImage(for URL: URL) -> UIImage? {
        cache.object(forKey: URL as NSURL)
    }
}
