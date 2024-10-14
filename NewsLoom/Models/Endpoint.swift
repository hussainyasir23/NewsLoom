//
//  Endpoint.swift
//  NewsLoom
//
//  Created by Yasir on 14/10/24.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}
