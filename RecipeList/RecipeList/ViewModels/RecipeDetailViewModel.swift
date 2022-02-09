//
//  RecipeDetailViewModel.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/09.
//

import Foundation


class RecipeDetailViewModel: BaseViewModel {
    /// キャッシュデーター追加
    func saveFavoritesPersistently(model: RecipeListMode) {
        var cacheArray: [RecipeListMode] = LocalStorageManager.cacheArray() ?? []
        
        let targets: [RecipeListMode] = cacheArray.filter { $0.id == model.id
        }
        if targets.count == 0 {
            cacheArray.insert(model, at: 0)
        }
        LocalStorageManager.setCache(array: cacheArray)
    }
    
    /// キャッシュデーター削除
    func deleteFavoritesPersistently(model: RecipeListMode) {
        
        let cacheArray: [RecipeListMode] = LocalStorageManager.cacheArray() ?? []
        var newArray: [RecipeListMode] = cacheArray
        for (index, element) in cacheArray.enumerated() {
            if element.id == model.id {
                newArray.remove(at: index)
            }
        }
        LocalStorageManager.setCache(array: newArray)
    }
}
