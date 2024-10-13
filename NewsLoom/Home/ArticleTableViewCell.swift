//
//  ArticleTableViewCell.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ArticleTableViewCell"
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .gray
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(sourceLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 12),
            
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            articleImageView.widthAnchor.constraint(equalToConstant: 80),
            articleImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            sourceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            sourceLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 12),
            sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description ?? "No description available"
        sourceLabel.text = article.source.name
        configureImage(with: article.urlToImage)
    }
    
    private func configureImage(with urlString: String?) {
        
        articleImageView.image = UIImage(systemName: "photo")
        
        guard let urlString = urlString,
              let imageUrl = URL(string: urlString) else {
            return
        }
        
        let processor = DownsamplingImageProcessor(size: articleImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 8)
        
        articleImageView.kf.indicatorType = .activity
        
        articleImageView.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(systemName: "photo"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ]
        ) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print("Image loading failed: \(error.localizedDescription)")
                self.articleImageView.image = UIImage(systemName: "exclamationmark.triangle")
            }
        }
    }
}
