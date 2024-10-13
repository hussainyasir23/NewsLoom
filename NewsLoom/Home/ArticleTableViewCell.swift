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
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(sourceLabel)
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            articleImageView.widthAnchor.constraint(equalToConstant: 80),
            articleImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            sourceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            sourceLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description ?? "No description available"
        sourceLabel.text = article.source.name
        articleImageView.image = nil
        articleImageView.kf.indicatorType = .activity
        
        if let imageUrlString = article.urlToImage,
           let imageUrl = URL(string: imageUrlString) {
            
            let processor = DownsamplingImageProcessor(size: articleImageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 8)
            
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
                    // Image successfully loaded
                    break
                case .failure(_):
                    // Handle failure (e.g., show a failure image)
                    self.articleImageView.image = UIImage(systemName: "photo.fill")
                }
            }
        } else {
            articleImageView.image = UIImage(systemName: "photo")
        }
    }
}
