//
//  Observable+ObjectMapper.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/07.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper


extension Response {
    
    func mapObjectModel<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        guard let object = Mapper<T>(context: context).map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
}


extension ObservableType where Element == Response {
    
    public func mapObjectModel<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObjectModel(T.self))
        }
    }
}
