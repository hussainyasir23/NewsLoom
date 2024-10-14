//
//  NewsLanguage.swift
//  NewsLoom
//
//  Created by Yasir on 14/10/24.
//

import Foundation

enum NewsLanguage: String, CaseIterable, Language {
    
    static var defaultLanguage: NewsLanguage {
        return .en
    }
    
    case ar, de, en, es, fr, he, it, nl, no, pt, ru, se, ud, zh
    
    var code: String {
        return rawValue
    }
    
    var name: String {
        switch self {
        case .ar: return "Arabic"
        case .de: return "German"
        case .en: return "English"
        case .es: return "Spanish"
        case .fr: return "French"
        case .he: return "Hebrew"
        case .it: return "Italian"
        case .nl: return "Dutch"
        case .no: return "Norwegian"
        case .pt: return "Portuguese"
        case .ru: return "Russian"
        case .se: return "Swedish"
        case .ud: return "Urdu"
        case .zh: return "Chinese"
        }
    }
}
