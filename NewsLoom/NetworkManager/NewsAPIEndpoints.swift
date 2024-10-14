//
//  NewsAPIEndpoints.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import Foundation

enum NewsAPIEndpoints: Endpoint {
    
    case topHeadlines(country: NewsCountry, page: Int, category: NewsCategory?)
    case everything(query: String, page: Int, sortBy: SortBy?)
    case sources(category: NewsCategory?, language: NewsLanguage?, country: NewsCountry?)
    
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
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .topHeadlines(let country, let page, let category):
            var params: [String: Any] = [
                "country": country.code,
                "page": page
            ]
            if let category = category {
                params["category"] = category.id
            }
            return params
            
        case .everything(let query, let page, let sortBy):
            var params: [String: Any] = [
                "q": query,
                "page": page
            ]
            if let sortBy = sortBy {
                params["sortBy"] = sortBy.rawValue
            }
            return params
            
        case .sources(let category, let language, let country):
            var params: [String: Any] = [:]
            if let category = category {
                params["category"] = category.id
            }
            if let language = language {
                params["language"] = language.code
            }
            if let country = country {
                params["country"] = country.code
            }
            return params.isEmpty ? nil : params
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
