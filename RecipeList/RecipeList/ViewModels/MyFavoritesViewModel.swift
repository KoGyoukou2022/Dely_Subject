//
//  MyFavoritesViewModel.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/09.
//

import Foundation
import RxSwift
import RxCocoa

class MyFavoritesViewModel: BaseViewModel {
    
    var data = BehaviorRelay<[RecipeListMode] > (value: [])
    
    func getData() {
        
        data.accept(LocalStorageManager.cacheArray() ?? [] )
        
    }
}
