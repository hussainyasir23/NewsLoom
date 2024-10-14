//
//  ArticleDetailViewController.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController {
    private let article: Article
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadArticle()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = article.source.name
        
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadArticle() {
        if let url = URL(string: article.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
