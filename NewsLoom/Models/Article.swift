//
//  Article.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import Foundation

struct Article: Codable, Identifiable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    var id: String { url }
}
