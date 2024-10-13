//
//  HomeViewController.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var isInitialLoad = true
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchTopHeadlines()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.refreshControl = refreshControl
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Top Headlines"
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updateUI(for: state)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(for state: ViewState) {
        switch state {
        case .idle:
            loadingIndicator.stopAnimating()
            errorLabel.isHidden = true
        case .loading:
            errorLabel.isHidden = true
            if isInitialLoad {
                loadingIndicator.startAnimating()
                tableView.isHidden = true
            } else {
                loadingIndicator.stopAnimating()
                tableView.isHidden = false
                if !refreshControl.isRefreshing {
                    refreshControl.beginRefreshing()
                }
            }
        case .loaded:
            loadingIndicator.stopAnimating()
            tableView.isHidden = false
            errorLabel.isHidden = true
            refreshControl.endRefreshing()
            tableView.reloadData()
            isInitialLoad = false
        case .error(let message):
            loadingIndicator.stopAnimating()
            refreshControl.endRefreshing()
            isInitialLoad = false
            if viewModel.numberOfArticles == 0 {
                tableView.isHidden = true
                errorLabel.isHidden = false
                errorLabel.text = message
            } else {
                tableView.isHidden = false
                showErrorToast(message: message)
            }
        }
    }
    
    @objc private func refreshData() {
        isInitialLoad = false
        viewModel.fetchTopHeadlines()
    }
    
    private func showErrorToast(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell,
              let article = viewModel.article(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let article = viewModel.article(at: indexPath.row) {
            let detailViewController = ArticleDetailViewController(article: article)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfArticles - 2 {
            viewModel.loadMore()
        }
    }
}
