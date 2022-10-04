//
//  DependencyProvider.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import Foundation

protocol DependencyProviderProtocol: AnyObject {

    var networkingEngine: NetworkingEngineProtocol { get }

    /// Image downloading & caching service.
//    var imageDownloader: ImageDownloader { get }
}

/// An default app dependencies provider.
final class DependencyProvider: DependencyProviderProtocol {
    var networkingEngine: NetworkingEngineProtocol
    

//    /// - SeeAlso: `DependencyProvider.productsNetworkController`
//    let productsNetworkController: ProductsNetworkController
//
//    /// - SeeAlso: `DependencyProvider.imageDownloader`
//    let imageDownloader: ImageDownloader

    /// A default initializer for dependency provider.
    init() {
        networkingEngine = NetworkingEngine()
//        let networkSession = URLSession(configuration: .default)
//        let requestBuilder = DefaultRequestBuilder(scheme: .https, host: "api.bloomandwild.com")
//        let networkController = DefaultNetworkController(requestBuilder: requestBuilder, session: networkSession)
//        productsNetworkController = DefaultProductsNetworkController(networkController: networkController)
//        let imageCache = DefaultImageCache()
//        imageDownloader = DefaultImageDownloader(networkSession: networkSession, imageCache: imageCache)
    }
}
