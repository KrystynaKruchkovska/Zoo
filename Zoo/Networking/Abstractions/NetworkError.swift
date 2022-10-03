//
//  NetworkError.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case responseError
    case unknown
}
