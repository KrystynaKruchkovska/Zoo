//
//  ZooEndpoint.swift
//  Zoo
//
//  Created by Paweł on 04/10/2022.
//

import Combine
import Foundation

enum ZooEndpoint: Endpoint {
    case getSearchResult(numberOfItems: Int)
    var scheme: String {
        return "https"
    }
    
    var baseUrl: String {
        return  "zoo-animal-api.herokuapp.com"
    }
    
    var path: String {
        switch self {
        case .getSearchResult(let numberOfItems):
            return "/animals/rand/\(numberOfItems)"
        }
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    var method: String {
        return HttpRequestMethod.GET.rawValue
    }
}


