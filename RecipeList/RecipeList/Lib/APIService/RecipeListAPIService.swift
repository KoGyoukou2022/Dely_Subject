//
//  RecipeListAPI.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/07.
//

import Foundation
import Moya

enum RecipeListAPIService{
    case RecipeList
}

extension RecipeListAPIService: TargetType {
    var baseURL: URL {
       return URL(string:"https://s3-ap-northeast-1.amazonaws.com")!
    }
    
    var path: String {
        switch self {
        case .RecipeList:
             return "/data.kurashiru.com/videos_sample.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .RecipeList:
             return .get
        }
    }
    
    var parameters: [String : Any]? {
        
        switch self {
        case .RecipeList:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
