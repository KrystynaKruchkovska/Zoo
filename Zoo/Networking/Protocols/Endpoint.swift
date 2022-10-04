//
//  Endpoint.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: String { get }
}
