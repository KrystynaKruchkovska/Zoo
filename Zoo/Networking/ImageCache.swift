//
//  ImageCache.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import UIKit

final class ImageCache: ImageCacheProtocol {
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
    
    func getImage(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }
}
