//
//  CollectionViewFlowLayoutModelView.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/06.
//

import UIKit
import RxSwift
import Moya
import RxCocoa
import ObjectMapper
import Alamofire
import SwiftUI

class RecipeListViewModel: BaseViewModel {
    
    private let provider = MoyaProvider<RecipeListAPIService>()
    var data = [RecipeListMode]()
    var dataWithfavor = BehaviorRelay<[(RecipeListMode, Bool)]>(value: [])
    var networkError = BehaviorRelay<Swift.Error?>(value: nil)
    
    func loadRecipeListDatawithMapObject() {
        provider.rx.request(.RecipeList).asObservable().mapObjectModel(RecipeListModelMapObject.self).subscribe ({ [unowned self] (event) in
            
            switch event {
            case let .next( model):
                
                self.data = model.data
                
            case let .error( error):
                print("\(error)")
                self.networkError.accept(error )
            case .completed:
                if data.count != 0 {
                    self.dataWithfavor.accept(obtainFavoritesFromDataList(dataList: self.data))
                }
                break
            }
        }).disposed(by: self.disposeBag)
    }
    
    func obtainFavoritesFromDataList(dataList: [RecipeListMode]) -> [(RecipeListMode, Bool)] {
        var dataWithfavor: [(RecipeListMode, Bool)] = []
        let cacheData: [RecipeListMode] = LocalStorageManager.cacheArray() ?? []
        
        for item in dataList {
            if cacheData.firstIndex(where: {$0.id == item.id}) != nil {
                dataWithfavor.append((item, true))
            } else {
                dataWithfavor.append((item, false))
            }
        }
        return dataWithfavor
    }
}

    
    
