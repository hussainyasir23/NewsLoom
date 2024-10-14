//
//  ArticleService.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import Foundation
import Combine

// MARK: - Article Service Protocol

protocol ArticleServicing {
    func fetchTopHeadlines(country: NewsCountry, category: NewsCategory?, page: Int) -> AnyPublisher<[Article], NewsAPIError>
    func fetchEverything(query: String, sortBy: SortBy?, page: Int) -> AnyPublisher<[Article], NewsAPIError>
    func fetchSources(category: NewsCategory?, language: NewsLanguage?, country: NewsCountry?) -> AnyPublisher<[Source], NewsAPIError>
}

// MARK: - Article Service Implementation

class ArticleService: ArticleServicing {
    
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchTopHeadlines(country: NewsCountry = .defaultCountry, category: NewsCategory? = nil, page: Int = 1) -> AnyPublisher<[Article], NewsAPIError> {
        return fetchArticles(endpoint: .topHeadlines(country: country, page: page, category: category))
    }
    
    func fetchEverything(query: String, sortBy: SortBy? = nil, page: Int = 1) -> AnyPublisher<[Article], NewsAPIError> {
        return fetchArticles(endpoint: .everything(query: query, page: page, sortBy: sortBy))
    }
    
    func fetchSources(category: NewsCategory? = nil, language: NewsLanguage? = nil, country: NewsCountry? = nil) -> AnyPublisher<[Source], NewsAPIError> {
        return networkManager.request(.sources(category: category, language: language, country: country))
            .map { (response: NewsAPIResponse) -> [Source] in
                response.sources ?? []
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchArticles(endpoint: NewsAPIEndpoints) -> AnyPublisher<[Article], NewsAPIError> {
        return networkManager.request(endpoint)
            .map { (response: NewsAPIResponse) -> [Article] in
                response.articles ?? []
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Helper Extensions

extension ArticleService {
    
    func fetchTopHeadlines(for category: NewsCategory, country: NewsCountry = .defaultCountry, page: Int = 1) -> AnyPublisher<[Article], NewsAPIError> {
        return fetchTopHeadlines(country: country, category: category, page: page)
    }
    
    func searchArticles(query: String, sortBy: SortBy = .publishedAt, page: Int = 1) -> AnyPublisher<[Article], NewsAPIError> {
        return fetchEverything(query: query, sortBy: sortBy, page: page)
    }
}
