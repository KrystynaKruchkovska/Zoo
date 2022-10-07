//
//  FakeImageCache.swift
//  ZooTests
//
//  Created by Paweł on 07/10/2022.
//

import UIKit

@testable import Zoo

final class FakeImageCache: ImageCacheProtocol {
    
    var fakeCache = [URL: UIImage]()
    
    func setImage(_ image: UIImage, for url: URL) {
        return fakeCache[url] = image
    }
    
    func getImage(for url: URL) -> UIImage? {
        return fakeCache[url]
    }
}

