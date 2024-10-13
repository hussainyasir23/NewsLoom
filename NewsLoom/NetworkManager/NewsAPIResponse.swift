//
//  NewsAPIResponse.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import Foundation

struct NewsAPIResponse: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    let sources: [Source]?
    let code: String?
    let message: String?
}
