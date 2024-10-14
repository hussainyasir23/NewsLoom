//
//  CategoriesViewModel.swift
//  NewsLoom
//
//  Created by Yasir on 14/10/24.
//

import Foundation

class CategoriesViewModel {
    
    let categories: [NewsCategory] = NewsCategory.allCases
    
    func selectCategory(_ category: NewsCategory) {
        print("Selected category: \(category.name)")
    }
}
