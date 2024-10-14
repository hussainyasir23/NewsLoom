//
//  NewsCategory.swift
//  NewsLoom
//
//  Created by Yasir on 14/10/24.
//

import Foundation

enum NewsCategory: String, CaseIterable, Category {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var id: String {
        return rawValue
    }
    
    var name: String {
        return rawValue.capitalized
    }
    
    var icon: String {
        switch self {
        case .business: return "briefcase"
        case .entertainment: return "film"
        case .general: return "newspaper"
        case .health: return "heart"
        case .science: return "flask"
        case .sports: return "sportscourt"
        case .technology: return "desktopcomputer"
        }
    }
}
