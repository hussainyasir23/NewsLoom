//
//  HomeViewModel.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import Foundation
import Combine

class HomeViewModel {
    
    @Published private(set) var state: ViewState = .idle
    private var articles: [Article] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let articleService: ArticleServicing
    
    private var currentPage = 1
    private var isLoadingMore = false
    private var hasMorePages = true
    
    init(articleService: ArticleServicing = ArticleService()) {
        self.articleService = articleService
    }
    
    func fetchTopHeadlines(isLoadingMore: Bool = false) {
        
        guard !isLoadingMore || (isLoadingMore && !self.isLoadingMore && hasMorePages) else {
            return
        }
        
        self.isLoadingMore = isLoadingMore
        
        if !isLoadingMore {
            state = .loading
            currentPage = 1
        }
        
        articleService.fetchTopHeadlines(country: .defaultCountry, category: nil, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else {
                    return
                }
                self.isLoadingMore = false
                switch completion {
                case .finished:
                    self.state = .loaded
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] newArticles in
                guard let self = self else {
                    return
                }
                if self.isLoadingMore {
                    self.articles.append(contentsOf: newArticles)
                } else {
                    self.articles = newArticles
                }
                self.hasMorePages = !newArticles.isEmpty
                self.currentPage += 1
            }
            .store(in: &cancellables)
    }
    
    func loadMore() {
        fetchTopHeadlines(isLoadingMore: true)
    }
    
    func article(at index: Int) -> Article? {
        guard index < articles.count else { return nil }
        return articles[index]
    }
    
    var numberOfArticles: Int {
        return articles.count
    }
}

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case error(String)
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.loaded, .loaded):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}
