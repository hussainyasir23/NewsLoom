//
//  NewsAPIEndpoints.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import Foundation

enum NewsAPIEndpoints: Endpoint {
    case topHeadlines(page: Int)
    case everything(query: String, page: Int)
    case sources
    
    var baseURL: String {
        return "https://newsapi.org"
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .everything:
            return "/v2/everything"
        case .sources:
            return "/v2/top-headlines/sources"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .topHeadlines(let page):
            return ["country": "us",
                    "page": page]
        case .everything(let query, let page):
            return ["q": query,
                    "page": page]
        case .sources:
            return nil
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
