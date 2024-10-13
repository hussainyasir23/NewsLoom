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
    func fetchTopHeadlines(page: Int) -> AnyPublisher<[Article], NewsAPIError>
    func fetchEverything(query: String, page: Int) -> AnyPublisher<[Article], NewsAPIError>
    func fetchSources() -> AnyPublisher<[Source], NewsAPIError>
}

// MARK: - Article Service Implementation

class ArticleService: ArticleServicing {
    
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchTopHeadlines(page: Int) -> AnyPublisher<[Article], NewsAPIError> {
        return fetchArticles(endpoint: .topHeadlines(page: page))
    }
    
    func fetchEverything(query: String, page: Int) -> AnyPublisher<[Article], NewsAPIError> {
        return fetchArticles(endpoint: .everything(query: query, page: page))
    }
    
    func fetchSources() -> AnyPublisher<[Source], NewsAPIError> {
        return networkManager.request(.sources)
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
